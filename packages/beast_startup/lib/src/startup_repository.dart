import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'in_app_update_service.dart';

/// A named initialization step.
class InitStep {
  /// Human-readable name (used for logging).
  final String name;

  /// The async function to run.
  final Future<void> Function() execute;

  const InitStep(this.name, this.execute);
}

/// A named initialization step that has access to a Riverpod [Ref].
///
/// Use this when your init step needs to read/listen to providers.
class RefInitStep {
  /// Human-readable name (used for logging).
  final String name;

  /// The async function to run with [Ref] access.
  final Future<void> Function(Ref ref) execute;

  const RefInitStep(this.name, this.execute);
}

/// Configuration for the app startup flow.
class DefaultStartupRepository {
  /// Minimum splash screen display duration.
  final Duration minSplashDuration = const Duration(seconds: 2);

  /// Whether to enable dev timing.
  final bool enableDevTiming = false;

  /// Ordered list of initialization steps to run at startup.
  final List<InitStep> steps = [];

  /// Ordered list of ref-aware initialization steps to run after [steps].
  ///
  /// These run after all regular [steps] and have access to a Riverpod [Ref].
  /// Use for setting up provider listeners, reading provider values, etc.
  final List<RefInitStep> refSteps = [];

  /// Optional callback for logging init progress.
  void logHandler(String message) {}

  /// Optional callback when an init step fails.
  void onStepError(String stepName, Object error, StackTrace stackTrace) {}

  /// Android Play Store in-app update behavior. Disabled by default.
  ///
  /// Override in your subclass to enable, e.g.:
  /// ```dart
  /// @override
  /// InAppUpdateConfig get updateConfig => const InAppUpdateConfig(
  ///       mode: BeastUpdateMode.flexible,
  ///     );
  /// ```
  InAppUpdateConfig get updateConfig => InAppUpdateConfig.disabled;

  /// Whether a failure in the update check should fail startup.
  /// Defaults to false — update errors are logged via [onUpdateError]
  /// and startup continues.
  bool get failStartupOnUpdateError => false;

  /// Called when the in-app update check throws.
  void onUpdateError(Object error, StackTrace stackTrace) {}
}

/// Provider for the startup config.
///
/// Override this in your app's [ProviderScope]:
/// ```dart
/// ProviderScope(
///   overrides: [
///     startupConfigProvider.overrideWithValue(StartupConfig(...)),
///   ],
///   child: MyApp(),
/// )
/// ```
