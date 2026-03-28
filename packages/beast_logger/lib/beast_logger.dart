/// A configurable Talker-based logging service for Flutter apps.
///
/// Provides a singleton [BeastLogger] with standard log levels,
/// pluggable custom log types, and integrations for Dio and Riverpod.
///
/// ```dart
/// // Initialize once at startup
/// final logger = BeastLogger.I;
///
/// // Use anywhere
/// logger.info('App started');
/// logger.error('Something failed', error, stackTrace);
///
/// // Create custom log types
/// class MyCustomLog extends BeastLog {
///   MyCustomLog(super.message);
///   @override String get title => 'MyFeature';
///   @override String get key => 'my_feature';
///   @override AnsiPen get pen => AnsiPen()..cyan();
/// }
/// logger.logCustom(MyCustomLog('Custom event'));
/// ```
library;

export 'src/logger_service.dart';
export 'src/custom_log.dart';

// Re-export commonly used Talker types so apps don't need direct talker imports
export 'package:talker_flutter/talker_flutter.dart'
    show
        Talker,
        TalkerScreen,
        TalkerRouteObserver,
        AnsiPen,
        TalkerLog,
        TalkerFilter,
        LogLevel,
        TalkerSettings;
export 'package:talker_dio_logger/talker_dio_logger.dart'
    show TalkerDioLogger, TalkerDioLoggerSettings;
export 'package:talker_riverpod_logger/talker_riverpod_logger.dart'
    show TalkerRiverpodObserver;
