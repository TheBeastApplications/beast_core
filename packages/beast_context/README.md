# Beast Context

BuildContext extensions and snackbar utilities for Flutter apps using GoRouter.

## Features

- `context.router` — Shortcut to access GoRouter from any BuildContext
- `context.snackbar.errorSnackBar(...)` — Show styled error snackbar with auto-detection of network errors
- `context.snackbar.successSnackBar(...)` — Show styled success snackbar
- `BeastSnackBar.onError` — Global error callback for logging

## Usage

```dart
import 'package:beast_context/beast_context.dart';

// Navigation
context.router.push('/home');
context.router.go('/login');

// Snackbars
context.snackbar.successSnackBar('Saved!');

context.snackbar.errorSnackBar(
  error: 'SocketException: Connection refused',
  errorMessage: 'Something went wrong',
);
// ^ Automatically shows "No internet connection" for SocketExceptions

// Global error logging
BeastSnackBar.onError = (error) => logger.error(error);
```
