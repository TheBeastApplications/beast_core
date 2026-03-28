# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

beast_core is a Flutter monorepo that bundles five loosely-coupled sub-packages into a single import (`package:beast_core/beast_core.dart`). Each package can also be used independently. The packages provide reusable infrastructure for Flutter apps: logging, navigation/snackbar extensions, app startup orchestration, RevenueCat subscription management, and onboarding state.

## Commands

```bash
# Install dependencies (run from root)
flutter pub get

# Code generation (required after modifying Riverpod providers or Freezed models)
flutter pub run build_runner build --delete-conflicting-outputs

# Static analysis
flutter analyze
```

There are no tests in the project currently.

## Architecture

### Repository Override Pattern

Every package follows the same pattern:
1. Package defines a `Default*Repository` abstract base class with sensible defaults
2. Consuming app creates a concrete subclass overriding specific methods
3. The subclass is injected via `ProviderScope.overrides` using the package's repository provider

This is the central design contract — all five packages use it.

### State Management

All state is managed via **Riverpod** with code generation (`@Riverpod` annotation + `riverpod_generator`). Key state providers:
- `appStartupProvider` — orchestrates initialization steps
- `subscriptionStateProvider` — tracks RevenueCat subscription status
- `isOnboardedProvider` — tracks onboarding completion

### Package Responsibilities

| Package | Purpose | Key Types |
|---------|---------|-----------|
| **beast_logger** | Talker-based logging with custom log types | `BeastLogger`, `BeastLog` |
| **beast_extensions** | `BuildContext` extensions for GoRouter (`.router`) and snackbars (`.snackbar`) | `BeastContextExtensions`, `BeastSnackBar` |
| **beast_startup** | Splash screen + ordered async initialization steps | `DefaultStartupRepository`, `InitStep`, `RefInitStep`, `BeastStartupScreen` |
| **beast_subscription** | RevenueCat wrapper with purchase/restore/entitlement gating | `DefaultSubscriptionRepository`, `SubscriptionConfig`, `SubscriptionData`, `SubscriptionState` |
| **beast_onboarding** | Async onboarding flag persistence | `DefaultOnboardingRepository`, `IsOnboarded` |

### Code Generation Artifacts

These generated files must exist for the project to compile:
- `*.g.dart` — Riverpod provider implementations (from `riverpod_generator`)
- `*.freezed.dart` — Freezed immutable data classes (in `beast_subscription`)

### Key External Dependencies

- **flutter_riverpod** / **riverpod_annotation** — state management
- **go_router** — navigation (exposed via context extensions)
- **talker_flutter** — logging backend
- **purchases_flutter** / **purchases_ui_flutter** — RevenueCat SDK
- **freezed_annotation** — immutable data models

## Conventions

- Packages have no inter-package dependencies; they only share Riverpod as a common state layer.
- Providers use `keepAlive: true` to persist across widget rebuilds.
- `SubscriptionState.executePremium<T>()` gates functionality behind subscription checks with auto-paywall.
- SDK constraints: Dart ≥3.9.2, Flutter ≥3.22.0.
