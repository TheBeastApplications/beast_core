# beast_core Complete Audit

**Date:** 2026-04-15
**Version:** 3.0.2
**Flutter SDK:** 3.41.5 | **Dart SDK:** 3.11.3

---

## Static Analysis: PASS

`flutter analyze` reports **no issues**.

---

## 1. Architecture

The repository override pattern is consistent across all 5 packages — each has a `Default*Repository` abstract class, a throwing provider, and expects the consumer app to override via `ProviderScope.overrides`. This is clean and well-structured.

---

## 2. Bugs & Issues

### [HIGH] Missing `await` in `setIsOnboarded` (provider)

**File:** `packages/beast_onboarding/lib/src/providers/onboarding_provider.dart:25`

```dart
Future<void> setIsOnboarded(bool value) async {
    await _onboardingRepository?.setValue(value);
    load();  // <-- missing await
}
```

`load()` is an async method that fetches the persisted value and updates state. Without `await`, the state update may not complete before callers proceed, causing stale reads.

### [HIGH] Missing `await` in `setIsOnboarded` (repository)

**File:** `packages/beast_onboarding/lib/src/repository/onboarding_repository.dart:11`

```dart
Future<void> setIsOnboarded(bool value) async {
    setValue(value);  // <-- missing await
}
```

`setValue` is `Future<void>` but is called without `await`.

### [MEDIUM] Force-unwrap on nullable value

**File:** `packages/beast_onboarding/lib/src/providers/onboarding_provider.dart:18`

```dart
final value = await _onboardingRepository?.getValue();
state = value;
return value!;  // <-- will throw if _onboardingRepository is null
```

If `_onboardingRepository` is null, `value` will be null and `value!` will crash.

### [MEDIUM] `SubscriptionState.build()` calls `initialize()` every rebuild

**File:** `packages/beast_subscription/lib/src/providers/subscription_provider.dart:27-31`

```dart
Future<SubscriptionData> build() async {
    await _repo.initialize();
    setupListener();
    return _loadSubscriptionData();
}
```

Every time this provider is invalidated (e.g., via `refresh()`), `initialize()` re-runs RevenueCat `Purchases.configure()` and `setDeviceAttributes()`. This may cause unintended behavior — RevenueCat SDK should only be configured once. The listener is also re-registered on each rebuild, which could lead to duplicate listeners.

### [LOW] `CustomTitleLogger` appears to be leftover example code

**File:** `packages/beast_logger/lib/src/logger_service.dart:45-53`

`CustomTitleLogger` doesn't follow the `BeastLog` base class pattern and looks like a development artifact.

---

## 3. Type Safety

### [MEDIUM] `dynamic context` instead of `BuildContext`

**Files:**
- `packages/beast_subscription/lib/src/subscription_repository.dart:152`
- `packages/beast_subscription/lib/src/providers/subscription_provider.dart:106`

```dart
void showPaywall(dynamic context) { ... }
Future<T?> executePremium<T>(Future<T?> Function() func, dynamic context, { ... })
```

These should use `BuildContext` since `showPaywall` in `SubscriptionConfig` expects `BuildContext`.

---

## 4. Testing: NONE

No tests exist across any package. Recommended minimum coverage:

- `SubscriptionData.fromCustomerInfo` logic (paid vs manual entitlement resolution)
- `IsOnboarded` state transitions (load, set, null safety)
- `appStartup` provider step sequencing and error handling
- `BeastSnackBar` error detection (`SocketException` string matching)

---

## 5. Dependency Observations

| Concern | Detail |
|---------|--------|
| `flutter_riverpod` version drift | `beast_extensions` pins `^3.3.1`, others use it transitively — works today but could diverge |
| `LogLevel` conflict | Correctly handled — `beast_subscription` explicitly avoids re-exporting RevenueCat's `LogLevel` to prevent collision with Talker's |
| `dart:io` usage | `subscription_repository.dart` uses `Platform.isAndroid/isIOS` directly — will crash on web. Fine if web is not a target |

---

## 6. Minor Nits

- `BeastSnackBar` allocates a new instance on every `context.snackbar` access — not a real perf issue, but worth noting.
- `DevTiming` singleton is mutated globally (`enabled` flag) from the startup provider — could cause issues if multiple tests run in parallel.
- The barrel file (`lib/beast_core.dart:16`) comment says `import 'package:beast_context/beast_context.dart'` but the actual package name is `beast_extensions`.

---

## Summary

| Category | Status |
|----------|--------|
| Static analysis | Clean |
| Architecture | Solid, consistent pattern |
| Bugs | 2 high, 2 medium, 1 low |
| Type safety | 1 medium (`dynamic` instead of `BuildContext`) |
| Tests | None |
| Dependencies | Healthy, no conflicts |
| Documentation | Good library-level docs |
