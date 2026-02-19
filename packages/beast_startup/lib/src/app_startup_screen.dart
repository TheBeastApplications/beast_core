import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_startup_provider.dart';
import 'startup_error_widget.dart';
import 'startup_loading_widget.dart';

/// A startup screen that watches [appStartupProvider] and shows
/// loading/error/loaded states automatically.
///
/// Usage:
/// ```dart
/// MaterialApp.router(
///   builder: (context, child) => BeastStartupScreen(
///     onLoaded: (context) => child!,
///   ),
/// )
/// ```
///
/// Customize the loading and error UI:
/// ```dart
/// BeastStartupScreen(
///   onLoaded: (context) => child!,
///   loadingBuilder: () => MyCustomSplash(),
///   errorBuilder: (error, onRetry) => MyCustomError(error, onRetry),
/// )
/// ```
class BeastStartupScreen extends ConsumerWidget {
  const BeastStartupScreen({
    super.key,
    required this.onLoaded,
    this.loadingBuilder,
    this.errorBuilder,
  });

  /// Builder called when startup completes successfully.
  final WidgetBuilder onLoaded;

  /// Optional custom loading widget builder.
  final Widget Function()? loadingBuilder;

  /// Optional custom error widget builder.
  final Widget Function(String error, VoidCallback onRetry)? errorBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (_) => onLoaded(context),
      loading: () =>
          loadingBuilder?.call() ?? const BeastStartupLoadingWidget(),
      error: (e, st) {
        return Scaffold(
          body:
              errorBuilder?.call(e.toString(), () {
                ref.invalidate(appStartupProvider);
              }) ??
              BeastStartupErrorWidget(
                error: e.toString(),
                onRetry: () => ref.invalidate(appStartupProvider),
              ),
        );
      },
    );
  }
}
