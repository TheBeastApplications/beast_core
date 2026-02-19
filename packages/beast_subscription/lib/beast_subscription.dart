/// A configurable RevenueCat wrapper with Riverpod state management.
///
/// Provides [BeastSubscriptionService] for SDK calls and
/// [SubscriptionState] Riverpod provider as the single source of truth.
///
/// ```dart
/// // 1. Initialize once at startup
/// await BeastSubscriptionService.I.initialize(
///   SubscriptionConfig(
///     androidApiKey: 'goog_xxx',
///     iosApiKey: 'appl_xxx',
///     entitlementId: 'premium',
///   ),
/// );
///
/// // 2. Read subscription state via Riverpod
/// final sub = ref.watch(subscriptionStateProvider);
/// sub.whenData((data) {
///   if (data.isSubscribed) { /* premium features */ }
/// });
///
/// // 3. Show RevenueCat paywall (optional)
/// RevenueCatUI.presentPaywallIfNeeded('premium');
/// ```
library beast_subscription;

export 'src/subscription_config.dart';
export 'src/providers/subscription_provider.dart';
export 'src/models/subscription_data_model.dart';
export 'src/providers/subscription_repository_provider.dart';
export 'src/subscription_repository.dart';

// Re-export commonly used RevenueCat types
export 'package:purchases_flutter/purchases_flutter.dart'
    show CustomerInfo, Package, Offerings, EntitlementInfo;
// Note: LogLevel is intentionally NOT re-exported here to avoid
// conflict with talker_flutter's LogLevel (from beast_logger).
// Use `purchases_flutter` directly if you need RevenueCat's LogLevel.
export 'package:purchases_ui_flutter/purchases_ui_flutter.dart'
    show PaywallView;
