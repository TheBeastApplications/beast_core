// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_startup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Orchestrates app initialization with configurable steps and minimum
/// splash duration.
///
/// This provider runs all [InitStep]s and [RefInitStep]s from [StartupConfig]
/// in sequence, while ensuring the splash screen is shown for at least
/// [StartupConfig.minSplashDuration].
///
/// Override [startupConfigProvider] in your app's [ProviderScope] to
/// supply your init steps.

@ProviderFor(appStartup)
final appStartupProvider = AppStartupProvider._();

/// Orchestrates app initialization with configurable steps and minimum
/// splash duration.
///
/// This provider runs all [InitStep]s and [RefInitStep]s from [StartupConfig]
/// in sequence, while ensuring the splash screen is shown for at least
/// [StartupConfig.minSplashDuration].
///
/// Override [startupConfigProvider] in your app's [ProviderScope] to
/// supply your init steps.

final class AppStartupProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Orchestrates app initialization with configurable steps and minimum
  /// splash duration.
  ///
  /// This provider runs all [InitStep]s and [RefInitStep]s from [StartupConfig]
  /// in sequence, while ensuring the splash screen is shown for at least
  /// [StartupConfig.minSplashDuration].
  ///
  /// Override [startupConfigProvider] in your app's [ProviderScope] to
  /// supply your init steps.
  AppStartupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStartupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStartupHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return appStartup(ref);
  }
}

String _$appStartupHash() => r'2c8af7b05d3d98792f616ae433219004cb8c90dd';
