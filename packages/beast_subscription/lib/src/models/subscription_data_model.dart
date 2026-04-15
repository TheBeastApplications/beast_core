import 'package:beast_subscription/src/subscription_config.dart';
import 'package:beast_subscription/src/subscription_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_data_model.freezed.dart';

/// Immutable subscription data model.
@freezed
abstract class SubscriptionData with _$SubscriptionData {
  const SubscriptionData._();

  const factory SubscriptionData({
    /// True if the user has the primary entitlement OR any manual entitlement.
    required bool isSubscribed,

    /// True if the user has the primary [SubscriptionConfig.entitlementId]
    /// (i.e. they paid for it through the store).
    required bool isPaidSubscriber,

    /// True if the user has an entitlement from [SubscriptionConfig.manualEntitlementIds]
    /// (i.e. granted manually via RevenueCat dashboard).
    required bool hasManualEntitlement,

    /// All currently active entitlement IDs on this user.
    required List<String> activeEntitlementIds,

    required CustomerInfo customerInfo,
  }) = _SubscriptionData;

  /// Create from [CustomerInfo] using the service's configured entitlement.
  factory SubscriptionData.fromCustomerInfo(
    CustomerInfo customerInfo,
    DefaultSubscriptionRepository service,
  ) {
    final activeIds = customerInfo.entitlements.active.keys.toList();
    final config = service.config;

    final isPaid = customerInfo.entitlements.active.containsKey(
      config.entitlementId,
    );

    final hasManual = config.manualEntitlementIds.any(
      (id) => customerInfo.entitlements.active.containsKey(id),
    );

    return SubscriptionData(
      isSubscribed: isPaid || hasManual,
      isPaidSubscriber: isPaid,
      hasManualEntitlement: hasManual,
      activeEntitlementIds: activeIds,
      customerInfo: customerInfo,
    );
  }

  /// Whether the user has any active entitlement (regardless of which one).
  bool get hasAnyEntitlement => customerInfo.entitlements.active.isNotEmpty;
}
