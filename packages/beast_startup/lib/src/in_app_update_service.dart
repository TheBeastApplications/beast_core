import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

/// How (and whether) to prompt the user for an Android Play Store update
/// during startup.
enum BeastUpdateMode {
  /// Don't check for updates.
  disabled,

  /// Show the blocking, full-screen Play update flow when an update is
  /// available. Startup waits for the user to accept/cancel.
  immediate,

  /// Start a background download when an update is available; surface a
  /// prompt to install via [InAppUpdateConfig.onFlexibleDownloaded].
  /// Startup does not wait for the download.
  flexible,
}

/// Configuration for the in-app update check that runs at startup.
class InAppUpdateConfig {
  const InAppUpdateConfig({
    this.mode = BeastUpdateMode.disabled,
    this.requireImmediateWhenAvailable = false,
    this.checkTimeout = const Duration(seconds: 5),
    this.onFlexibleDownloaded,
  });

  /// Disabled by default — opt in by overriding [DefaultStartupRepository.updateConfig].
  static const InAppUpdateConfig disabled = InAppUpdateConfig();

  /// Which update flow to run.
  final BeastUpdateMode mode;

  /// In [BeastUpdateMode.immediate], if the user dismisses the update,
  /// re-check on next startup. Set to true to escalate to immediate even
  /// when [AppUpdateInfo.immediateUpdateAllowed] is false (no-op if Play
  /// disallows it).
  final bool requireImmediateWhenAvailable;

  /// Maximum time to wait for [InAppUpdate.checkForUpdate] to return
  /// before giving up. Prevents startup from hanging if Play Services
  /// is slow/unreachable. On timeout, the check is skipped and startup
  /// continues normally (the timeout is routed through `onUpdateError`).
  final Duration checkTimeout;

  /// Callback fired once a flexible update finishes downloading. Typical
  /// use: show a snackbar offering "Restart to update", then call
  /// [BeastInAppUpdate.completeFlexibleUpdate]. If null, the update
  /// stays staged and Play applies it on the next cold start.
  final Future<void> Function()? onFlexibleDownloaded;
}

/// Thin wrapper around the [in_app_update] plugin so consumers don't need
/// a direct dependency. All methods are no-ops on non-Android platforms.
class BeastInAppUpdate {
  const BeastInAppUpdate._();

  static bool get _isAndroid => !kIsWeb && Platform.isAndroid;

  static Future<AppUpdateInfo?> checkForUpdate() async {
    if (!_isAndroid) return null;
    return InAppUpdate.checkForUpdate();
  }

  static Future<AppUpdateResult?> performImmediateUpdate() async {
    if (!_isAndroid) return null;
    return InAppUpdate.performImmediateUpdate();
  }

  static Future<AppUpdateResult?> startFlexibleUpdate() async {
    if (!_isAndroid) return null;
    return InAppUpdate.startFlexibleUpdate();
  }

  static Future<void> completeFlexibleUpdate() async {
    if (!_isAndroid) return;
    await InAppUpdate.completeFlexibleUpdate();
  }
}

/// Runs the configured update flow. Safe to call on any platform.
///
/// Returns normally on success or when no update is needed. Throws on
/// plugin errors so the caller can decide whether to swallow or fail
/// startup.
Future<void> runInAppUpdate(
  InAppUpdateConfig config, {
  void Function(String message)? log,
}) async {
  if (config.mode == BeastUpdateMode.disabled) return;
  if (!BeastInAppUpdate._isAndroid) {
    log?.call('in_app_update: skipped (non-Android platform)');
    return;
  }

  final info = await BeastInAppUpdate.checkForUpdate().timeout(
    config.checkTimeout,
    onTimeout: () {
      log?.call(
        'in_app_update: checkForUpdate timed out after '
        '${config.checkTimeout.inMilliseconds}ms, skipping',
      );
      return null;
    },
  );
  if (info == null) return;

  // If a prior flexible download finished but never got installed
  // (user dismissed or never saw the prompt), install it now on this
  // cold start. Play shows a brief full-screen install UI then restarts
  // into the new version.
  if (info.installStatus == InstallStatus.downloaded) {
    log?.call('in_app_update: completing previously-downloaded update');
    await BeastInAppUpdate.completeFlexibleUpdate();
    return;
  }

  if (info.updateAvailability != UpdateAvailability.updateAvailable) {
    log?.call('in_app_update: no update available');
    return;
  }

  switch (config.mode) {
    case BeastUpdateMode.disabled:
      return;
    case BeastUpdateMode.immediate:
      if (info.immediateUpdateAllowed || config.requireImmediateWhenAvailable) {
        log?.call('in_app_update: starting immediate update');
        await BeastInAppUpdate.performImmediateUpdate();
      } else {
        log?.call('in_app_update: immediate not allowed by Play, skipping');
      }
      return;
    case BeastUpdateMode.flexible:
      if (!info.flexibleUpdateAllowed) {
        log?.call('in_app_update: flexible not allowed by Play, skipping');
        return;
      }
      log?.call('in_app_update: starting flexible update (background)');
      // Fire and forget — don't block startup on the download.
      // ignore: unawaited_futures
      BeastInAppUpdate.startFlexibleUpdate().then((result) async {
        if (result == AppUpdateResult.success &&
            config.onFlexibleDownloaded != null) {
          await config.onFlexibleDownloaded!();
        }
      });
      return;
  }
}
