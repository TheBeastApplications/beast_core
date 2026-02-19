# Beast Onboarding

A configurable onboarding wrapper with Riverpod state management for Flutter apps.

## Features

- **`DefaultOnboardingRepository`** — Abstract base for persisting onboarding state (SharedPreferences, Hive, etc.)
- **`IsOnboarded`** — Riverpod provider that tracks whether the user has completed onboarding
- **Repository override pattern** — Bring your own storage implementation

## Usage

### 1. Create your onboarding repository

```dart
class AppOnboardingRepository extends DefaultOnboardingRepository {
  final SharedPreferences _prefs;
  AppOnboardingRepository(this._prefs);

  @override
  Future<bool> getValue() async => _prefs.getBool('onboarded') ?? false;

  @override
  Future<void> setValue(bool value) async => _prefs.setBool('onboarded', value);
}
```

### 2. Override the provider

```dart
ProviderScope(
  overrides: [
    onboardingRepositoryProvider.overrideWithValue(
      AppOnboardingRepository(prefs),
    ),
  ],
  child: MyApp(),
)
```

### 3. Use in routing / UI

```dart
final isOnboarded = ref.watch(isOnboardedProvider);

if (isOnboarded == false) {
  return OnboardingScreen();
}

// Mark onboarding complete
ref.read(isOnboardedProvider.notifier).setIsOnboarded(true);
```
