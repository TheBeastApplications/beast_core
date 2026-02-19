import 'package:flutter/material.dart';

/// Default loading widget shown during app initialization.
///
/// Shows a centered circular progress indicator on a dark background.
/// Override with [BeastStartupScreen.loadingBuilder] for custom UI.
class BeastStartupLoadingWidget extends StatelessWidget {
  const BeastStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
