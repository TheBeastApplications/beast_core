import 'package:beast_subscription/src/subscription_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_data_model.freezed.dart';

/// Immutable subscription data model.
@freezed
abstract class SubscriptionData with _$SubscriptionData {
  const SubscriptionData._();

  const factory SubscriptionData({
    required bool isSubscribed,
    required CustomerInfo customerInfo,
  }) = _SubscriptionData;

  /// Create from [CustomerInfo] using the service's configured entitlement.
  factory SubscriptionData.fromCustomerInfo(
    CustomerInfo customerInfo,
    DefaultSubscriptionRepository service,
  ) {
    return SubscriptionData(
      isSubscribed: service.hasEntitlement(customerInfo),
      customerInfo: customerInfo,
    );
  }

  /// Whether the user has any active entitlement (regardless of which one).
  bool get hasAnyEntitlement => customerInfo.entitlements.active.isNotEmpty;
}
