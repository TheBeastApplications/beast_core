# Beast Subscription

A configurable RevenueCat wrapper with Riverpod state management for Flutter subscription apps.

## Features

- **`DefaultSubscriptionRepository`** — Abstract base with RevenueCat SDK calls (initialize, purchase, restore, login/logout, device attributes)
- **`SubscriptionState`** — Riverpod provider as the single source of truth for subscription status
- **`SubscriptionData`** — Freezed model with paid vs manual entitlement tracking
- **`SubscriptionConfig`** — Configuration for API keys, entitlements, log handler, and paywall callback
- **`executePremium()`** — Gate any function behind a subscription check with auto-paywall
- **Device attributes** — Automatically sets device name, model, manufacturer, OS version as RevenueCat subscriber attributes

## Setup

### 1. Create your subscription repository

```dart
class AppSubscriptionRepository extends DefaultSubscriptionRepository {
  @override
  SubscriptionConfig config = SubscriptionConfig(
    androidApiKey: 'goog_xxx',
    iosApiKey: 'appl_xxx',
    entitlementId: 'premium',
    // Entitlements you grant manually via RevenueCat dashboard
    manualEntitlementIds: ['beta_access', 'gifted_premium'],
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

## Reading Subscription State

```dart
final sub = ref.watch(subscriptionStateProvider);
sub.whenData((data) {
  data.isSubscribed;          // true if paid OR manual entitlement
  data.isPaidSubscriber;      // true only if user has the primary entitlementId (paid through store)
  data.hasManualEntitlement;  // true only if user has an entitlement from manualEntitlementIds
  data.activeEntitlementIds;  // all active entitlement keys, e.g. ['premium', 'beta_access']
  data.hasAnyEntitlement;     // true if any entitlement is active (even unlisted ones)
  data.customerInfo;          // raw RevenueCat CustomerInfo
});
```

## Gating Features with `executePremium`

```dart
final notifier = ref.read(subscriptionStateProvider.notifier);

// Default — any configured entitlement (paid or manual) passes
await notifier.executePremium(
  () async => doSomething(),
  context,
);

// Only paid store subscribers (manual entitlements rejected)
await notifier.executePremium(
  () async => doSomething(),
  context,
  paidOnly: true,
);

// Only users with a specific entitlement
await notifier.executePremium(
  () async => doSomething(),
  context,
  entitlementId: 'beta_access',
);
```

If the user doesn't have the required entitlement, `showPaywall` is called automatically and the function returns `null`.

## Paid vs Manual Entitlements

RevenueCat lets you grant entitlements manually from the dashboard (e.g. for beta testers, gifted users, support cases). To distinguish these from store purchases:

1. Set `entitlementId` to your primary paid entitlement (e.g. `'premium'`)
2. Set `manualEntitlementIds` to entitlements you grant manually (e.g. `['beta_access', 'gifted_premium']`)
3. Use `isPaidSubscriber` / `hasManualEntitlement` to check the source

```dart
sub.whenData((data) {
  if (data.isPaidSubscriber) {
    // User paid through the App Store / Play Store
  } else if (data.hasManualEntitlement) {
    // You granted this from RevenueCat dashboard
  }
});
```

## Device Attributes

On initialization, device info is automatically sent to RevenueCat as subscriber attributes (fire-and-forget, non-blocking):

| Platform | Attributes |
|----------|-----------|
| Android  | `device_name`, `device_manufacturer`, `device_brand`, `os_version`, `sdk_version`, `device_product` |
| iOS      | `device_name`, `device_model`, `os_version` |

These are visible per-subscriber in the RevenueCat dashboard. Override `setDeviceAttributes()` in your repository subclass to customize or disable:

```dart
class AppSubscriptionRepository extends DefaultSubscriptionRepository {
  @override
  Future<void> setDeviceAttributes() async {
    // Call super to keep defaults, then add your own
    await super.setDeviceAttributes();
    await Purchases.setAttributes({'app_version': '2.1.0'});
  }
}
```

## Other Operations

```dart
final notifier = ref.read(subscriptionStateProvider.notifier);

// Purchase
final packages = await notifier.getAvailablePackages();
await notifier.purchasePackage(packages.first);

// Restore purchases
await notifier.restorePurchases();

// Login / logout (links RevenueCat user to your user ID)
await notifier.login('user_123');
await notifier.logout();

// Force refresh from RevenueCat
await notifier.refresh();

// Get RevenueCat user ID
final userId = notifier.getUserId();
```

## SubscriptionConfig Reference

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `androidApiKey` | `String` | yes | — | RevenueCat API key for Android |
| `iosApiKey` | `String` | yes | — | RevenueCat API key for iOS |
| `entitlementId` | `String` | yes | — | Primary entitlement ID for paid access |
| `manualEntitlementIds` | `List<String>` | no | `[]` | Entitlement IDs granted manually via dashboard |
| `logHandler` | `void Function(String)?` | no | `null` | Log callback for SDK events |
| `showPaywall` | `void Function(BuildContext)?` | no | `null` | Callback to show paywall when gating fails |
| `verboseLogging` | `bool` | no | `false` | Enable verbose RevenueCat SDK logs |

## SubscriptionData Reference

| Field | Type | Description |
|-------|------|-------------|
| `isSubscribed` | `bool` | `true` if user has primary OR any manual entitlement |
| `isPaidSubscriber` | `bool` | `true` if user has the primary `entitlementId` (store purchase) |
| `hasManualEntitlement` | `bool` | `true` if user has any entitlement from `manualEntitlementIds` |
| `activeEntitlementIds` | `List<String>` | All active entitlement keys on the user |
| `hasAnyEntitlement` | `bool` | `true` if any entitlement is active (even unlisted) |
| `customerInfo` | `CustomerInfo` | Raw RevenueCat customer info |
