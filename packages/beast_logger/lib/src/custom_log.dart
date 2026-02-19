import 'package:talker_flutter/talker_flutter.dart';

/// Base class for creating custom log types.
///
/// Extend this to create domain-specific logs with custom titles and colors.
///
/// Example:
/// ```dart
/// class RevenueCatLog extends BeastLog {
///   RevenueCatLog(super.message);
///
///   @override
///   String get title => 'RevenueCat';
///
///   @override
///   String get key => 'revenue_cat';
///
///   @override
///   AnsiPen get pen => AnsiPen()..magenta();
/// }
///
/// // Usage
/// logger.logCustom(RevenueCatLog('Purchase completed'));
/// ```
abstract class BeastLog extends TalkerLog {
  BeastLog(super.message);
}
