import 'package:beast_onboarding/src/providers/onboarding_repository_provider.dart';
import 'package:beast_onboarding/src/repository/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
class IsOnboarded extends _$IsOnboarded {
  DefaultOnboardingRepository? _onboardingRepository;

  @override
  bool? build() {
    _onboardingRepository = ref.read(onboardingRepositoryProvider);
    return null;
  }

  Future<bool> load() async {
    final value = await _onboardingRepository?.getValue();
    state = value;
    return value!;
  }

  Future<void> setIsOnboarded(bool value) async {
    await _onboardingRepository?.setValue(value);
    load();
  }
}
