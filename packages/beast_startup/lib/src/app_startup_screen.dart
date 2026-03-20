import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_startup_provider.dart';
import 'startup_error_widget.dart';
import 'startup_loading_widget.dart';

/// A startup screen that watches [appStartupProvider] and shows
/// loading/error/loaded states automatically.
///
/// Transitions between states are animated with a smooth fade + scale effect.
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
    this.transitionDuration = const Duration(milliseconds: 600),
  });

  /// Builder called when startup completes successfully.
  final WidgetBuilder onLoaded;

  /// Optional custom loading widget builder.
  final Widget Function()? loadingBuilder;

  /// Optional custom error widget builder.
  final Widget Function(String error, VoidCallback onRetry)? errorBuilder;

  /// Duration of the crossfade transition between loading and loaded states.
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);

    final child = appStartupState.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (_) => KeyedSubtree(
        key: const ValueKey('loaded'),
        child: onLoaded(context),
      ),
      loading: () => KeyedSubtree(
        key: const ValueKey('loading'),
        child: loadingBuilder?.call() ?? const BeastStartupLoadingWidget(),
      ),
      error: (e, st) => KeyedSubtree(
        key: const ValueKey('error'),
        child: Scaffold(
          body: errorBuilder?.call(e.toString(), () {
                ref.invalidate(appStartupProvider);
              }) ??
              BeastStartupErrorWidget(
                error: e.toString(),
                onRetry: () => ref.invalidate(appStartupProvider),
              ),
        ),
      ),
    );

    return AnimatedSwitcher(
      duration: transitionDuration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (widget, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: widget,
          ),
        );
      },
      child: child,
    );
  }
}
