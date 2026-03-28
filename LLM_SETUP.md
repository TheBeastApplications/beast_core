# Beast Core — LLM Setup Instructions

> **Usage:** Paste this file (or a link to it) into any LLM conversation and say:
> *"Set up beast_core in this Flutter app."*

---

## What to do

You are integrating the `beast_core` Flutter package into an existing Flutter app. Follow every step below exactly.

### Step 1 — Add the dependency

In the app's `pubspec.yaml`, add `beast_core` as a path dependency pointing to the beast_core package location. Also ensure these dev dependencies exist for code generation:

```yaml
dependencies:
  beast_core:
    path: ../packages/beast_core  # adjust relative path as needed
  flutter_riverpod: ^3.3.1
  go_router: ^17.1.0

dev_dependencies:
  build_runner: ^2.13.1
  riverpod_generator: ^4.0.3
```

Then run `flutter pub get`.

### Step 2 — Create repository implementations

Create a file `lib/core/beast_repositories.dart` with concrete implementations of all three repository abstract classes. Adjust the bodies to match the app's needs.

```dart
import 'package:beast_core/beast_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ──────────────────────────────────────────────
// Startup
// ──────────────────────────────────────────────
class AppStartupRepository extends DefaultStartupRepository {
  @override
  Duration get minSplashDuration => const Duration(seconds: 2);

  @override
  bool get enableDevTiming => true;

  @override
  List<InitStep> get steps => [
        // Add non-Riverpod init steps here
        // InitStep('Load config', () async { ... }),
      ];

  @override
  List<RefInitStep> get refSteps => [
        RefInitStep('Subscriptions', (ref) async {
          await ref.read(subscriptionStateProvider.future);
        }),
        RefInitStep('Onboarding', (ref) async {
          await ref.read(isOnboardedProvider.notifier).load();
        }),
      ];

  @override
  void logHandler(String message) {
    BeastLogger().info(message);
  }

  @override
  void onStepError(String stepName, Object error, StackTrace stackTrace) {
    BeastLogger().error('Startup step "$stepName" failed', error, stackTrace);
  }
}

// ──────────────────────────────────────────────
// Subscription (RevenueCat)
// ──────────────────────────────────────────────
class AppSubscriptionRepository extends DefaultSubscriptionRepository {
  @override
  SubscriptionConfig get config => SubscriptionConfig(
        androidApiKey: 'goog_YOUR_KEY',
        iosApiKey: 'appl_YOUR_KEY',
        entitlementId: 'premium',
        logHandler: (msg) => BeastLogger().info(msg),
        showPaywall: (context) {
          // Navigate to your paywall screen
        },
        verboseLogging: false,
      );
}

// ──────────────────────────────────────────────
// Onboarding
// ──────────────────────────────────────────────
class AppOnboardingRepository extends DefaultOnboardingRepository {
  // Replace with SharedPreferences, Hive, or any async storage
  bool _value = false;

  @override
  Future<bool> getValue() async => _value;

  @override
  Future<void> setValue(bool value) async => _value = value;
}
```

### Step 3 — Wire into main.dart

Wrap the app in a `ProviderScope` with all three repository overrides, and use `BeastStartupScreen` as the root widget.

```dart
import 'package:beast_core/beast_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/beast_repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: configure global snackbar error logging
  BeastSnackBar.onError = (error) {
    BeastLogger().error('Snackbar error: $error');
  };

  runApp(
    ProviderScope(
      overrides: [
        startupRepositoryProvider.overrideWithValue(AppStartupRepository()),
        subscriptionRepositoryProvider.overrideWithValue(AppSubscriptionRepository()),
        onboardingRepositoryProvider.overrideWithValue(AppOnboardingRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider),
      builder: (context, child) => BeastStartupScreen(
        onLoaded: (context) => child!,
        // Optional custom builders:
        // loadingBuilder: () => MyCustomLoader(),
        // errorBuilder: (error, retry) => MyCustomError(error, retry),
      ),
    );
  }
}
```

### Step 4 — Set up GoRouter with onboarding redirect

Create a file `lib/core/router.dart`:

```dart
import 'package:beast_core/beast_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final onboardingNotifier = ref.read(isOnboardedProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: ref.onboardingRefreshListenable,
    redirect: (context, state) {
      final isOnboarded = ref.read(isOnboardedProvider);
      if (isOnboarded == false && state.uri.path != '/onboarding') {
        return '/onboarding';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    ],
  );
}
```

Then run code generation:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 5 — Use beast_core APIs throughout the app

**Logging:**
```dart
final logger = BeastLogger();
logger.info('Something happened');
logger.error('Failed', exception, stackTrace);
logger.custom(MyCustomLog('details'));  // extend BeastLog for custom types
```

**Navigation & snackbars (via context extensions):**
```dart
context.router.push('/settings');
context.snackbar.successSnackBar('Saved!');
context.snackbar.errorSnackBar(error: e.toString(), errorMessage: 'Something went wrong');
```

**Gate features behind subscription:**
```dart
final result = await ref.read(subscriptionStateProvider.notifier).executePremium<String>(
  () async => 'premium result',
  context,  // shows paywall automatically if not subscribed
);
```

**Complete onboarding:**
```dart
await ref.read(isOnboardedProvider.notifier).setIsOnboarded(true);
// GoRouter auto-redirects via refreshListenable
```

---

## Provider override reference

| Provider to override | Concrete class to create | Required |
|---|---|---|
| `startupRepositoryProvider` | extends `DefaultStartupRepository` | Yes |
| `subscriptionRepositoryProvider` | extends `DefaultSubscriptionRepository` | Yes (or remove subscription refStep) |
| `onboardingRepositoryProvider` | extends `DefaultOnboardingRepository` | Yes (or remove onboarding refStep) |

## Key state providers (read-only, do not override)

| Provider | Type | Purpose |
|---|---|---|
| `appStartupProvider` | `AsyncValue<void>` | Startup orchestration state |
| `subscriptionStateProvider` | `AsyncValue<SubscriptionData>` | Subscription status |
| `isOnboardedProvider` | `bool?` | Onboarding flag (`null` = not yet loaded) |
