abstract class DefaultOnboardingRepository {
  Future<bool> getIsOnboarded() async {
    return getValue();
  }

  Future<bool> getValue();

  Future<void> setValue(bool value);

  Future<void> setIsOnboarded(bool value) async {
    setValue(value);
  }
}
