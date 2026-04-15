import 'package:talker_flutter/talker_flutter.dart';

class BeastLogger {
  BeastLogger({
    TalkerFilter? filter,
    LogLevel level = LogLevel.verbose,
    bool enabled = true,
    bool useConsoleLogs = true,
  }) : talker = Talker(
         filter: filter ?? TalkerFilter(),
         logger: TalkerLogger(settings: TalkerLoggerSettings(level: level)),
         settings: TalkerSettings(
           enabled: enabled,
           useConsoleLogs: useConsoleLogs,
         ),
       );

  final Talker talker;

  // --- passthrough helpers ---

  void debug(String msg, [Object? e, StackTrace? st]) =>
      talker.debug(msg, e, st);

  void info(String msg, [Object? e, StackTrace? st]) => talker.info(msg, e, st);

  void warning(String msg, [Object? e, StackTrace? st]) =>
      talker.warning(msg, e, st);

  void error(String msg, [Object? e, StackTrace? st]) =>
      talker.error(msg, e, st);

  void critical(String msg, [Object? e, StackTrace? st]) =>
      talker.critical(msg, e, st);

  void custom(TalkerLog log) => talker.logCustom(log);

  void setEnabled(bool value) => talker.settings.enabled = value;

  void setLevel(LogLevel value) => talker.configure(
    logger: TalkerLogger(settings: TalkerLoggerSettings(level: value)),
  );
}

class CustomTitleLogger extends TalkerLog {
  CustomTitleLogger(super.message);

  @override
  String get title => 'CustomTitle';

  @override
  String get key => 'custom_title';
}
