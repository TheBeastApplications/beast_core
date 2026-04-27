import 'dart:async';
import 'package:beast_startup/src/in_app_update_service.dart';
import 'package:beast_startup/src/startup_repository_provider.dart';
import 'package:beast_startup/src/timing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_startup_provider.g.dart';

/// Orchestrates app initialization with configurable steps and minimum
/// splash duration.
///
/// This provider runs all [InitStep]s and [RefInitStep]s from [StartupConfig]
/// in sequence, while ensuring the splash screen is shown for at least
/// [StartupConfig.minSplashDuration].
///
/// Override [startupConfigProvider] in your app's [ProviderScope] to
/// supply your init steps.
@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  final repo = ref.read(startupRepositoryProvider);

  DevTiming.instance.enabled = repo.enableDevTiming;

  final stopwatch = repo.enableDevTiming ? (Stopwatch()..start()) : null;

  final minDurationCompleter = Completer<void>();
  final timer = Timer(repo.minSplashDuration, () {
    minDurationCompleter.complete();
  });

  repo.logHandler('Starting app initialization...');

  try {
    // Android Play Store in-app update check (no-op when disabled or
    // on non-Android platforms).
    if (repo.updateConfig.mode != BeastUpdateMode.disabled) {
      try {
        await runInAppUpdate(repo.updateConfig, log: repo.logHandler);
      } catch (e, stackTrace) {
        repo.onUpdateError(e, stackTrace);
        if (repo.failStartupOnUpdateError) rethrow;
      }
    }

    // Run each init step in sequence
    for (final step in repo.steps) {
      if (stopwatch != null) {
        repo.logHandler(
          "Start ${step.name} at ${stopwatch.elapsedMilliseconds} ms",
        );
      }
      repo.logHandler('Running init step: ${step.name}');
      try {
        await step.execute();
        repo.logHandler('${step.name} initialized');
      } catch (e, stackTrace) {
        repo.onStepError(step.name, e, stackTrace);
        rethrow;
      } finally {
        if (stopwatch != null) {
          repo.logHandler(
            "End ${step.name} at ${stopwatch.elapsedMilliseconds} ms",
          );
        }
      }
    }

    // Run ref-aware steps (provider wiring, etc.)
    for (final step in repo.refSteps) {
      if (stopwatch != null) {
        repo.logHandler(
          "Start ${step.name} at ${stopwatch.elapsedMilliseconds} ms",
        );
      }
      repo.logHandler('Running ref step: ${step.name}');
      try {
        await step.execute(ref);
        repo.logHandler('${step.name} initialized');
      } catch (e, stackTrace) {
        repo.onStepError(step.name, e, stackTrace);
        rethrow;
      } finally {
        if (stopwatch != null) {
          repo.logHandler(
            "End ${step.name} at ${stopwatch.elapsedMilliseconds} ms",
          );
        }
      }
    }

    // Wait for minimum splash duration
    final isTimerStillActive = timer.isActive;
    if (stopwatch != null) {
      repo.logHandler(
        isTimerStillActive
            ? "Waiting for minimum duration... at ${stopwatch.elapsedMilliseconds} ms, minimum duration is ${repo.minSplashDuration.inMilliseconds} ms"
            : "Init took longer than minimum duration at ${stopwatch.elapsedMilliseconds} ms, minimum duration is ${repo.minSplashDuration.inMilliseconds} ms",
      );
    }

    await minDurationCompleter.future;
    if (stopwatch != null) {
      stopwatch.stop();
    }
    repo.logHandler('App startup complete');
  } catch (e) {
    repo.logHandler('App initialization failed: $e');
    rethrow;
  } finally {
    timer.cancel();
  }
}
