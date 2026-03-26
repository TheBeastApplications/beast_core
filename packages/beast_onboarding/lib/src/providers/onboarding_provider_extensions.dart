import 'package:beast_onboarding/beast_onboarding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension OnboardingRouterExtension on Ref {
  ValueNotifier<bool> get onboardingRefreshListenable {
    if (read(isOnboardedProvider) == null) {
      read(isOnboardedProvider.notifier).load();
    }

    final notifier = ValueNotifier<bool>(read(isOnboardedProvider) ?? false);

    listen(isOnboardedProvider, (_, next) {
      if (next != null) notifier.value = next;
    });

    onDispose(notifier.dispose);
    return notifier;
  }
}
