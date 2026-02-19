# Beast Subscription

A configurable RevenueCat wrapper with Riverpod state management for Flutter subscription apps.

## Features

- **`DefaultSubscriptionRepository`** — Abstract base with RevenueCat SDK calls (initialize, purchase, restore, etc.)
- **`SubscriptionState`** — Riverpod provider as the single source of truth for subscription status
- **`SubscriptionData`** — Freezed model with `isSubscribed`, `customerInfo`, and helpers
- **`SubscriptionConfig`** — Configuration for API keys, entitlement ID, log handler, and paywall callback
- **`executePremium()`** — Gate any function behind a subscription check with auto-paywall

## Usage

### 1. Create your subscription repository

```dart
class AppSubscriptionRepository extends DefaultSubscriptionRepository {
  @override
  SubscriptionConfig config = SubscriptionConfig(
    androidApiKey: 'goog_xxx',
    iosApiKey: 'appl_xxx',
    entitlementId: 'premium',
    logHandler: (msg) => logger.debug(msg),
    showPaywall: (context) => context.push('/paywall'),
  );
}
```

### 2. Override the provider

```dart
ProviderScope(
  overrides: [
    subscriptionRepositoryProvider.overrideWithValue(
      AppSubscriptionRepository(),
    ),
  ],
  child: MyApp(),
)
```

### 3. Read subscription state

```dart
final sub = ref.watch(subscriptionStateProvider);
sub.whenData((data) {
  if (data.isSubscribed) {
    // Premium features
  }
});
```

### 4. Gate features

```dart
await ref.read(subscriptionStateProvider.notifier).executePremium(
  () async => doExpensiveOperation(),
  context,
);
```
