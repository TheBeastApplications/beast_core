// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionData {

/// True if the user has the primary entitlement OR any manual entitlement.
 bool get isSubscribed;/// True if the user has the primary [SubscriptionConfig.entitlementId]
/// (i.e. they paid for it through the store).
 bool get isPaidSubscriber;/// True if the user has an entitlement from [SubscriptionConfig.manualEntitlementIds]
/// (i.e. granted manually via RevenueCat dashboard).
 bool get hasManualEntitlement;/// All currently active entitlement IDs on this user.
 List<String> get activeEntitlementIds; CustomerInfo get customerInfo;
/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<SubscriptionData> get copyWith => _$SubscriptionDataCopyWithImpl<SubscriptionData>(this as SubscriptionData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionData&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.isPaidSubscriber, isPaidSubscriber) || other.isPaidSubscriber == isPaidSubscriber)&&(identical(other.hasManualEntitlement, hasManualEntitlement) || other.hasManualEntitlement == hasManualEntitlement)&&const DeepCollectionEquality().equals(other.activeEntitlementIds, activeEntitlementIds)&&(identical(other.customerInfo, customerInfo) || other.customerInfo == customerInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed,isPaidSubscriber,hasManualEntitlement,const DeepCollectionEquality().hash(activeEntitlementIds),customerInfo);

@override
String toString() {
  return 'SubscriptionData(isSubscribed: $isSubscribed, isPaidSubscriber: $isPaidSubscriber, hasManualEntitlement: $hasManualEntitlement, activeEntitlementIds: $activeEntitlementIds, customerInfo: $customerInfo)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDataCopyWith<$Res>  {
  factory $SubscriptionDataCopyWith(SubscriptionData value, $Res Function(SubscriptionData) _then) = _$SubscriptionDataCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed, bool isPaidSubscriber, bool hasManualEntitlement, List<String> activeEntitlementIds, CustomerInfo customerInfo
});




}
/// @nodoc
class _$SubscriptionDataCopyWithImpl<$Res>
    implements $SubscriptionDataCopyWith<$Res> {
  _$SubscriptionDataCopyWithImpl(this._self, this._then);

  final SubscriptionData _self;
  final $Res Function(SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscribed = null,Object? isPaidSubscriber = null,Object? hasManualEntitlement = null,Object? activeEntitlementIds = null,Object? customerInfo = null,}) {
  return _then(_self.copyWith(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,isPaidSubscriber: null == isPaidSubscriber ? _self.isPaidSubscriber : isPaidSubscriber // ignore: cast_nullable_to_non_nullable
as bool,hasManualEntitlement: null == hasManualEntitlement ? _self.hasManualEntitlement : hasManualEntitlement // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlementIds: null == activeEntitlementIds ? _self.activeEntitlementIds : activeEntitlementIds // ignore: cast_nullable_to_non_nullable
as List<String>,customerInfo: null == customerInfo ? _self.customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
as CustomerInfo,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionData].
extension SubscriptionDataPatterns on SubscriptionData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionData value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionData value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubscribed,  bool isPaidSubscriber,  bool hasManualEntitlement,  List<String> activeEntitlementIds,  CustomerInfo customerInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.isSubscribed,_that.isPaidSubscriber,_that.hasManualEntitlement,_that.activeEntitlementIds,_that.customerInfo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubscribed,  bool isPaidSubscriber,  bool hasManualEntitlement,  List<String> activeEntitlementIds,  CustomerInfo customerInfo)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData():
return $default(_that.isSubscribed,_that.isPaidSubscriber,_that.hasManualEntitlement,_that.activeEntitlementIds,_that.customerInfo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubscribed,  bool isPaidSubscriber,  bool hasManualEntitlement,  List<String> activeEntitlementIds,  CustomerInfo customerInfo)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.isSubscribed,_that.isPaidSubscriber,_that.hasManualEntitlement,_that.activeEntitlementIds,_that.customerInfo);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionData extends SubscriptionData {
  const _SubscriptionData({required this.isSubscribed, required this.isPaidSubscriber, required this.hasManualEntitlement, required final  List<String> activeEntitlementIds, required this.customerInfo}): _activeEntitlementIds = activeEntitlementIds,super._();
  

/// True if the user has the primary entitlement OR any manual entitlement.
@override final  bool isSubscribed;
/// True if the user has the primary [SubscriptionConfig.entitlementId]
/// (i.e. they paid for it through the store).
@override final  bool isPaidSubscriber;
/// True if the user has an entitlement from [SubscriptionConfig.manualEntitlementIds]
/// (i.e. granted manually via RevenueCat dashboard).
@override final  bool hasManualEntitlement;
/// All currently active entitlement IDs on this user.
 final  List<String> _activeEntitlementIds;
/// All currently active entitlement IDs on this user.
@override List<String> get activeEntitlementIds {
  if (_activeEntitlementIds is EqualUnmodifiableListView) return _activeEntitlementIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeEntitlementIds);
}

@override final  CustomerInfo customerInfo;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDataCopyWith<_SubscriptionData> get copyWith => __$SubscriptionDataCopyWithImpl<_SubscriptionData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionData&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.isPaidSubscriber, isPaidSubscriber) || other.isPaidSubscriber == isPaidSubscriber)&&(identical(other.hasManualEntitlement, hasManualEntitlement) || other.hasManualEntitlement == hasManualEntitlement)&&const DeepCollectionEquality().equals(other._activeEntitlementIds, _activeEntitlementIds)&&(identical(other.customerInfo, customerInfo) || other.customerInfo == customerInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed,isPaidSubscriber,hasManualEntitlement,const DeepCollectionEquality().hash(_activeEntitlementIds),customerInfo);

@override
String toString() {
  return 'SubscriptionData(isSubscribed: $isSubscribed, isPaidSubscriber: $isPaidSubscriber, hasManualEntitlement: $hasManualEntitlement, activeEntitlementIds: $activeEntitlementIds, customerInfo: $customerInfo)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDataCopyWith<$Res> implements $SubscriptionDataCopyWith<$Res> {
  factory _$SubscriptionDataCopyWith(_SubscriptionData value, $Res Function(_SubscriptionData) _then) = __$SubscriptionDataCopyWithImpl;
@override @useResult
$Res call({
 bool isSubscribed, bool isPaidSubscriber, bool hasManualEntitlement, List<String> activeEntitlementIds, CustomerInfo customerInfo
});




}
/// @nodoc
class __$SubscriptionDataCopyWithImpl<$Res>
    implements _$SubscriptionDataCopyWith<$Res> {
  __$SubscriptionDataCopyWithImpl(this._self, this._then);

  final _SubscriptionData _self;
  final $Res Function(_SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,Object? isPaidSubscriber = null,Object? hasManualEntitlement = null,Object? activeEntitlementIds = null,Object? customerInfo = null,}) {
  return _then(_SubscriptionData(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,isPaidSubscriber: null == isPaidSubscriber ? _self.isPaidSubscriber : isPaidSubscriber // ignore: cast_nullable_to_non_nullable
as bool,hasManualEntitlement: null == hasManualEntitlement ? _self.hasManualEntitlement : hasManualEntitlement // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlementIds: null == activeEntitlementIds ? _self._activeEntitlementIds : activeEntitlementIds // ignore: cast_nullable_to_non_nullable
as List<String>,customerInfo: null == customerInfo ? _self.customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
as CustomerInfo,
  ));
}


}

// dart format on
