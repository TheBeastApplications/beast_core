import 'package:flutter/material.dart';

/// A utility class for showing styled snackbars.
///
/// Access via `context.snackbar` when using [BeastContextExtensions].
///
/// ```dart
/// context.snackbar.errorSnackBar(
///   error: 'Something went wrong',
///   errorMessage: 'Please try again',
/// );
/// context.snackbar.successSnackBar('Saved successfully');
/// ```
class BeastSnackBar {
  final BuildContext _context;

  /// Optional callback invoked when an error snackbar is shown.
  /// Apps can use this to log errors.
  static void Function(String error)? onError;

  BeastSnackBar(this._context);

  /// Show an error snackbar.
  ///
  /// [error] is the technical error (logged via [onError] if set).
  /// [errorMessage] is shown to the user. Automatically detects
  /// `SocketException` and shows "No internet connection".
  void errorSnackBar({
    required String error,
    required String errorMessage,
    bool showClose = true,
    SnackBarAction? action,
  }) {
    if (error.contains('SocketException')) {
      errorMessage = 'No internet connection';
    }

    onError?.call(error);

    ScaffoldMessenger.of(_context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text(errorMessage),
          showCloseIcon: showClose,
          action: action,
        ),
      );
  }

  /// Show a success snackbar.
  void successSnackBar(String message) {
    ScaffoldMessenger.of(_context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(message),
          showCloseIcon: true,
        ),
      );
  }
}
