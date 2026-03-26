import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_snackbar.dart';

/// Convenience extensions on [BuildContext] for navigation and snackbars.
extension BeastContextExtensions on BuildContext {
  /// Shortcut to access [GoRouter] from context.
  GoRouter get router => GoRouter.of(this);

  /// Shortcut to show snackbars via [BeastSnackBar].
  BeastSnackBar get snackbar => BeastSnackBar(this);
}
