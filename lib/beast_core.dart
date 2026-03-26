/// All-in-one Beast toolkit for Flutter.
///
/// This is a convenience package that re-exports every Beast package
/// so you only need a single import:
///
/// ```dart
/// import 'package:beast_core/beast_core.dart';
/// ```
///
/// You can also import individual packages directly if you only need
/// a subset:
///
/// ```dart
/// import 'package:beast_logger/beast_logger.dart';
/// import 'package:beast_context/beast_context.dart';
/// ```

// Logging — Talker-based logger with custom log types, Dio & Riverpod support
export 'package:beast_logger/beast_logger.dart';

// Context — BuildContext extensions for GoRouter navigation & snackbars
export 'package:beast_extensions/beast_extensions.dart';

// Startup — Splash screen orchestration with init steps & loading/error UI
export 'package:beast_startup/beast_startup.dart';

// Subscription — RevenueCat wrapper with Riverpod state management
export 'package:beast_subscription/beast_subscription.dart';

// Onboarding — Onboarding flow with Riverpod state management
export 'package:beast_onboarding/beast_onboarding.dart';
