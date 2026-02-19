import 'package:beast_startup/src/startup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startupRepositoryProvider = Provider<DefaultStartupRepository>((ref) {
  throw UnimplementedError(
    'You must override `startupRepositoryProvider` in your app with a concrete implementation.',
  );
});
