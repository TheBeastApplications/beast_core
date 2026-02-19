// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(SubscriptionState)
final subscriptionStateProvider = SubscriptionStateProvider._();

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
final class SubscriptionStateProvider
    extends $AsyncNotifierProvider<SubscriptionState, SubscriptionData> {
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
  SubscriptionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionStateHash();

  @$internal
  @override
  SubscriptionState create() => SubscriptionState();
}

String _$subscriptionStateHash() => r'96dbaf07b7206cead31fa62f7d581805b393a03f';

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

abstract class _$SubscriptionState extends $AsyncNotifier<SubscriptionData> {
  FutureOr<SubscriptionData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SubscriptionData>, SubscriptionData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SubscriptionData>, SubscriptionData>,
              AsyncValue<SubscriptionData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
