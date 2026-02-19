# Beast Core

All-in-one Beast toolkit for Flutter — bundles every Beast package into a single dependency.

## Included Packages

| Package                                           | Description                                                                 |
| ------------------------------------------------- | --------------------------------------------------------------------------- |
| [beast_logger](packages/beast_logger)             | Talker-based logging with custom log types, Dio & Riverpod integrations     |
| [beast_context](packages/beast_context)           | BuildContext extensions for GoRouter navigation & styled snackbars          |
| [beast_startup](packages/beast_startup)           | App startup orchestration with splash screen, init steps & loading/error UI |
| [beast_subscription](packages/beast_subscription) | RevenueCat wrapper with Riverpod-based subscription state management        |
| [beast_onboarding](packages/beast_onboarding)     | Onboarding flow with Riverpod state management                              |

## Usage

### Use everything with a single import

```yaml
# pubspec.yaml
dependencies:
  beast_core:
    path: ../packages/beast_core # or version from pub.dev
```

```dart
import 'package:beast_core/beast_core.dart';

// Now you have access to all Beast APIs
final logger = BeastLogger();
logger.info('App started');

context.router.push('/home');
context.snackbar.successSnackBar('Done!');
```

### Use individual packages

You can also depend on only the packages you need:

```yaml
dependencies:
  beast_logger:
    path: ../packages/beast_logger
```

```dart
import 'package:beast_logger/beast_logger.dart';
```

## Architecture

Each Beast package follows the **repository override pattern**:

1. The package provides an abstract `Default*Repository` with sensible defaults.
2. Your app creates a concrete subclass.
3. You override the repository provider in your `ProviderScope`.

This keeps the packages framework-agnostic and fully configurable.
