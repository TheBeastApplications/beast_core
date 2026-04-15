import 'package:flutter/material.dart';

/// Configuration for the RevenueCat subscription service.
class SubscriptionConfig {
  /// RevenueCat API key for Android.
  final String androidApiKey;

  /// RevenueCat API key for iOS.
  final String iosApiKey;

  /// The entitlement ID to check for premium access (e.g. 'premium', 'pro').
  final String entitlementId;

  /// Optional log handler for RevenueCat SDK logs.
  /// Connect to your logger: `logHandler: (msg) => logger.logCustom(...)`.
  final void Function(String message)? logHandler;

  /// Whether to enable verbose RevenueCat logging (default: false).
  final bool verboseLogging;

  /// Entitlement IDs that are granted manually via RevenueCat dashboard
  /// (not through in-app purchase). Used to distinguish paid vs manual access.
  final List<String> manualEntitlementIds;

  /// Callback to navigate to the paywall screen.
  final void Function(BuildContext context)? showPaywall;

  const SubscriptionConfig({
    required this.androidApiKey,
    required this.iosApiKey,
    required this.entitlementId,
    this.manualEntitlementIds = const [],
    this.logHandler,
    this.showPaywall,
    this.verboseLogging = false,
  });
}
