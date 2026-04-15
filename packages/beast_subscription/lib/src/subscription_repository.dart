import 'dart:io';

import 'package:beast_subscription/beast_subscription.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class DefaultSubscriptionRepository {
  abstract SubscriptionConfig config;
  bool _initialized = false;
  bool _listenerRegistered = false;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      final apiKey = Platform.isAndroid
          ? config.androidApiKey
          : config.iosApiKey;

      if (apiKey.isEmpty) {
        config.logHandler?.call('RevenueCat API key not configured');
        return;
      }

      if (config.verboseLogging) {
        Purchases.setLogLevel(LogLevel.verbose);
      }

      if (config.logHandler != null) {
        await Purchases.setLogHandler(
          (logLevel, message) => config.logHandler!(message),
        );
      }

      await Purchases.configure(PurchasesConfiguration(apiKey));
      config.logHandler?.call('RevenueCat SDK configured');

      // Set device info as subscriber attributes (fire and forget)
      setDeviceAttributes();
      _initialized = true;
    } catch (e) {
      config.logHandler?.call('Failed to initialize RevenueCat: $e');
      rethrow;
    }
  }

  /// Collects device info and sets it as RevenueCat subscriber attributes.
  /// Override to add custom attributes or skip device info collection.
  Future<void> setDeviceAttributes() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final attributes = <String, String>{};

      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        attributes['device_name'] = android.model;
        attributes['device_manufacturer'] = android.manufacturer;
        attributes['device_brand'] = android.brand;
        attributes['os_version'] = 'Android ${android.version.release}';
        attributes['sdk_version'] = android.version.sdkInt.toString();
        attributes['device_product'] = android.product;
      } else if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        attributes['device_name'] = ios.name;
        attributes['device_model'] = ios.utsname.machine;
        attributes['os_version'] = 'iOS ${ios.systemVersion}';
      }

      if (attributes.isNotEmpty) {
        await Purchases.setAttributes(attributes);
        config.logHandler?.call('Device attributes set: $attributes');
      }
    } catch (e) {
      config.logHandler?.call('Failed to set device attributes: $e');
    }
  }

  /// Update RevenueCat log level at runtime.
  void setVerboseLogging(bool enabled) {
    Purchases.setLogLevel(enabled ? LogLevel.verbose : LogLevel.info);
  }

  void setupListener(Function(CustomerInfo) onUpdate) {
    if (_listenerRegistered) return;
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      onUpdate(customerInfo);
    });
    _listenerRegistered = true;
  }

  /// Fetch latest customer info from RevenueCat.
  Future<CustomerInfo> getCustomerInfo() async {
    return await Purchases.getCustomerInfo();
  }

  /// Get available subscription packages.
  Future<List<Package>> getAvailablePackages() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        return offerings.current!.availablePackages;
      }
    } catch (e) {
      config.logHandler?.call('Failed to get available packages: $e');
    }
    return [];
  }

  /// Purchase a package. Returns updated [CustomerInfo] on success, null on failure.
  Future<CustomerInfo?> purchasePackage(Package package) async {
    try {
      final purchase = await Purchases.purchase(
        PurchaseParams.package(package),
      );
      config.logHandler?.call('Purchase successful');
      return purchase.customerInfo;
    } catch (e) {
      config.logHandler?.call('Purchase failed: $e');
      return null;
    }
  }

  Future<void> loginWithUserId(String userId) async {
    await Purchases.logIn(userId);
  }

  Future<void> logout() async {
    await Purchases.logOut();
  }

  /// Restore previous purchases. Returns updated [CustomerInfo] on success, null on failure.
  Future<CustomerInfo?> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      config.logHandler?.call('Purchases restored');
      return customerInfo;
    } catch (e) {
      config.logHandler?.call('Failed to restore purchases: $e');
      return null;
    }
  }

  /// Check if the given [CustomerInfo] has the configured entitlement.
  bool hasEntitlement(CustomerInfo? customerInfo) {
    if (customerInfo == null) return false;
    return customerInfo.entitlements.active.containsKey(config.entitlementId);
  }

  /// Static version for use without instance — checks a specific entitlement.
  static bool checkEntitlement(
    CustomerInfo? customerInfo,
    String entitlementId,
  ) {
    if (customerInfo == null) return false;
    return customerInfo.entitlements.active.containsKey(entitlementId);
  }

  /// Show the paywall if a callback is configured.
  void showPaywall(dynamic context) {
    if (config.showPaywall != null) {
      config.showPaywall!(context);
    } else {
      config.logHandler?.call('showPaywall called but no callback configured');
    }
  }
}
