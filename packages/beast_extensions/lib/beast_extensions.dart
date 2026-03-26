/// BuildContext extensions and snackbar utilities for Flutter apps.
///
/// Provides convenient [BuildContext] extensions for GoRouter navigation
/// and snackbar display.
///
/// ```dart
/// // Navigation
/// context.router.push('/home');
///
/// // Snackbars
/// context.snackbar.errorSnackBar(
///   error: 'Error details',
///   errorMessage: 'User-facing message',
/// );
/// context.snackbar.successSnackBar('Done!');
/// ```
library beast_context;

export 'src/build_context_extensions.dart';
export 'src/custom_snackbar.dart';
