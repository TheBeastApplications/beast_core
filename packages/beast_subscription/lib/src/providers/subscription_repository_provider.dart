import 'package:beast_subscription/src/subscription_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionRepositoryProvider = Provider<DefaultSubscriptionRepository>((
  ref,
) {
  throw UnimplementedError(
    'You must override `subscriptionRepositoryProvider` in your app with a concrete implementation.',
  );
});
