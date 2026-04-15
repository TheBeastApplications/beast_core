import 'dart:async';
import 'package:beast_subscription/beast_subscription.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_provider.g.dart';

/// Single source of truth for subscription state.
///
/// All subscription status checks should go through this provider.
/// [BeastSubscriptionService] is used only for SDK calls; this provider
/// owns and exposes the reactive subscription state.
///
/// Usage:
/// ```dart
/// final sub = ref.watch(subscriptionStateProvider);
/// sub.whenData((data) {
///   print('Subscribed: ${data.isSubscribed}');
///   print('User ID: ${data.customerInfo.originalAppUserId}');
/// });
/// ```
@Riverpod(keepAlive: true)
class SubscriptionState extends _$SubscriptionState {
  DefaultSubscriptionRepository get _repo =>
      ref.read(subscriptionRepositoryProvider);

  @override
  Future<SubscriptionData> build() async {
    await _repo.initialize();
    setupListener();
    return _loadSubscriptionData();
  }

  /// Register a listener for realtime customer info updates.
  void setupListener() {
    _repo.setupListener((customerInfo) {
      refreshPurchaserInfo(customerInfo);
    });
  }

  Future<void> login(String userId) async {
    await _repo.loginWithUserId(userId);
    await refresh();
  }

  Future<void> logout() async {
    await _repo.logout();
    await refresh();
  }

  Future<SubscriptionData> _loadSubscriptionData() async {
    final customerInfo = await _repo.getCustomerInfo();
    return SubscriptionData.fromCustomerInfo(customerInfo, _repo);
  }

  /// Returns the RevenueCat user ID, or empty string if not yet loaded.
  String getUserId() {
    return state.value?.customerInfo.originalAppUserId ?? '';
  }

  /// Update state with new [CustomerInfo] (e.g. after a purchase or restore).
  Future<void> refreshPurchaserInfo(CustomerInfo customerInfo) async {
    final data = SubscriptionData.fromCustomerInfo(customerInfo, _repo);
    if (state.value != data) {
      state = AsyncData(data);
    }
  }

  /// Re-fetch subscription data from RevenueCat.
  Future<SubscriptionData> refresh() async {
    ref.invalidateSelf();
    return await future;
  }

  /// Purchase a package.
  Future<CustomerInfo?> purchasePackage(Package package) async {
    final result = await _repo.purchasePackage(package);
    if (result != null) {
      await refreshPurchaserInfo(result);
    }
    return result;
  }

  /// Restore previous purchases.
  Future<CustomerInfo?> restorePurchases() async {
    final result = await _repo.restorePurchases();
    if (result != null) {
      await refreshPurchaserInfo(result);
    }
    return result;
  }

  /// Get available offerings/packages.
  Future<List<Package>> getAvailablePackages() async {
    return _repo.getAvailablePackages();
  }

  /// Execute [func] only if the user has the required entitlement.
  ///
  /// - [paidOnly]: if `true`, only allows users who paid through the store
  ///   (ignores manual entitlements). Defaults to `false` (any entitlement).
  /// - [entitlementId]: if set, only allows users who have this specific
  ///   entitlement active. Overrides both [paidOnly] and the default check.
  Future<T?> executePremium<T>(
    Future<T?> Function() func,
    dynamic context, {
    bool paidOnly = false,
    String? entitlementId,
  }) async {
    final data = await ref.read(subscriptionStateProvider.future);

    final bool allowed;
    if (entitlementId != null) {
      allowed = data.activeEntitlementIds.contains(entitlementId);
    } else if (paidOnly) {
      allowed = data.isPaidSubscriber;
    } else {
      allowed = data.isSubscribed;
    }

    if (!allowed) {
      _repo.showPaywall(context);
      return null;
    }
    return await func();
  }
}
