class DevTiming {
  DevTiming._();

  static final DevTiming instance = DevTiming._();

  bool enabled = false;

  Future<T> time<T>(
    String label,
    Future<T> Function() task, {
    void Function(String)? log,
  }) async {
    if (!enabled) return task();

    final watch = Stopwatch()..start();

    final result = await task();

    watch.stop();

    log?.call('$label took ${watch.elapsedMilliseconds} ms');

    return result;
  }
}
