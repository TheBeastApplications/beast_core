/// A configurable app startup framework for Flutter with Riverpod.
///
/// Provides a startup provider that orchestrates init steps with a
/// minimum splash duration, plus ready-to-use startup screens.
///
///class StartupRepository extends DefaultStartupRepository {}
/// ```dart
/// // 1. Override the config provider with your app's init steps
/// ProviderScope(
///   overrides: [
///     startupRepositoryProvider.overrideWithValue(StartupRepository())
///   ],
///   child: MyApp(),
/// )
///
/// // 2. Use BeastStartupScreen in your MaterialApp builder
/// MaterialApp.router(
///   builder: (context, child) => BeastStartupScreen(
///     onLoaded: (context) => child!,
///   ),
/// )
/// ```
library;

export 'src/app_startup_provider.dart';
export 'src/app_startup_screen.dart';
export 'src/startup_loading_widget.dart';
export 'src/startup_error_widget.dart';
export 'src/startup_repository.dart';
export 'src/startup_repository_provider.dart';
