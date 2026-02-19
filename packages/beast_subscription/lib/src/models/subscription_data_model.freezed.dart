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

 bool get isSubscribed; CustomerInfo get customerInfo;
/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<SubscriptionData> get copyWith => _$SubscriptionDataCopyWithImpl<SubscriptionData>(this as SubscriptionData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionData&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.customerInfo, customerInfo) || other.customerInfo == customerInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed,customerInfo);

@override
String toString() {
  return 'SubscriptionData(isSubscribed: $isSubscribed, customerInfo: $customerInfo)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDataCopyWith<$Res>  {
  factory $SubscriptionDataCopyWith(SubscriptionData value, $Res Function(SubscriptionData) _then) = _$SubscriptionDataCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed, CustomerInfo customerInfo
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
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscribed = null,Object? customerInfo = null,}) {
  return _then(_self.copyWith(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,customerInfo: null == customerInfo ? _self.customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubscribed,  CustomerInfo customerInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.isSubscribed,_that.customerInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubscribed,  CustomerInfo customerInfo)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData():
return $default(_that.isSubscribed,_that.customerInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubscribed,  CustomerInfo customerInfo)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.isSubscribed,_that.customerInfo);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionData extends SubscriptionData {
  const _SubscriptionData({required this.isSubscribed, required this.customerInfo}): super._();
  

@override final  bool isSubscribed;
@override final  CustomerInfo customerInfo;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDataCopyWith<_SubscriptionData> get copyWith => __$SubscriptionDataCopyWithImpl<_SubscriptionData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionData&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.customerInfo, customerInfo) || other.customerInfo == customerInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed,customerInfo);

@override
String toString() {
  return 'SubscriptionData(isSubscribed: $isSubscribed, customerInfo: $customerInfo)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDataCopyWith<$Res> implements $SubscriptionDataCopyWith<$Res> {
  factory _$SubscriptionDataCopyWith(_SubscriptionData value, $Res Function(_SubscriptionData) _then) = __$SubscriptionDataCopyWithImpl;
@override @useResult
$Res call({
 bool isSubscribed, CustomerInfo customerInfo
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
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,Object? customerInfo = null,}) {
  return _then(_SubscriptionData(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,customerInfo: null == customerInfo ? _self.customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
as CustomerInfo,
  ));
}


}

// dart format on
