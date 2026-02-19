# Beast Logger

A configurable [Talker](https://pub.dev/packages/talker_flutter)-based logging service for Flutter apps with custom log types, Dio integration, and Riverpod observer support.

## Features

- Singleton-style `BeastLogger` with standard log levels (debug, info, warning, error, critical)
- Custom log types via `BeastLog` abstract class
- Built-in Dio HTTP logging via `TalkerDioLogger`
- Built-in Riverpod observer via `TalkerRiverpodObserver`
- Re-exports commonly used Talker types — no need for direct `talker_flutter` imports

## Usage

```dart
import 'package:beast_logger/beast_logger.dart';

// Create a logger instance
final logger = BeastLogger();

// Standard logging
logger.info('App started');
logger.debug('Loading user data...');
logger.error('Request failed', error, stackTrace);

// Custom log type
class RevenueCatLog extends BeastLog {
  RevenueCatLog(super.message);
  @override String get title => 'RevenueCat';
  @override String get key => 'revenue_cat';
  @override AnsiPen get pen => AnsiPen()..magenta();
}

logger.custom(RevenueCatLog('Purchase completed'));

// Dio integration
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: logger.talker));

// Riverpod observer
ProviderScope(
  observers: [TalkerRiverpodObserver(talker: logger.talker)],
  child: MyApp(),
);
```
