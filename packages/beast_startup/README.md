# Beast Startup

A configurable app startup framework for Flutter with Riverpod. Provides splash screen orchestration, init step sequencing, and loading/error UI.

## Features

- **`DefaultStartupRepository`** — Define ordered init steps (plain + Ref-aware)
- **`BeastStartupScreen`** — Drop-in widget that shows loading/error/loaded states
- **Minimum splash duration** — Ensures branding is visible even with fast init
- **Dev timing** — Optional stopwatch logging for each init step
- **Customizable UI** — Override loading and error builders

## Usage

### 1. Create your startup repository

```dart
class AppStartupRepository extends DefaultStartupRepository {
  @override
  Duration get minSplashDuration => const Duration(seconds: 2);

  @override
  bool get enableDevTiming => true;

  @override
  List<InitStep> get steps => [
    InitStep('Firebase', () => Firebase.initializeApp()),
    InitStep('Crashlytics', () => setupCrashlytics()),
  ];

  @override
  List<RefInitStep> get refSteps => [
    RefInitStep('Subscription', (ref) async {
      await ref.read(subscriptionStateProvider.future);
    }),
  ];

  @override
  void logHandler(String message) => logger.debug(message);
}
```

### 2. Override the provider

```dart
ProviderScope(
  overrides: [
    startupRepositoryProvider.overrideWithValue(AppStartupRepository()),
  ],
  child: MyApp(),
)
```

### 3. Use the startup screen

```dart
MaterialApp.router(
  builder: (context, child) => BeastStartupScreen(
    onLoaded: (context) => child!,
    loadingBuilder: () => MySplashScreen(),
    errorBuilder: (error, onRetry) => MyErrorScreen(error, onRetry),
  ),
)
```
