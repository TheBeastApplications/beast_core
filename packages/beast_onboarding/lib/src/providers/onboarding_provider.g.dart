// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsOnboarded)
final isOnboardedProvider = IsOnboardedProvider._();

final class IsOnboardedProvider extends $NotifierProvider<IsOnboarded, bool?> {
  IsOnboardedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOnboardedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOnboardedHash();

  @$internal
  @override
  IsOnboarded create() => IsOnboarded();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool?>(value),
    );
  }
}

String _$isOnboardedHash() => r'4a74053a32083cbcd80f32180e09fb1ae0a34b8e';

abstract class _$IsOnboarded extends $Notifier<bool?> {
  bool? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool?, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool?, bool?>,
              bool?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
