# System patterns

## Architecture

Feature-first layout under `lib/features/` with `data`, `domain`, and `presentation` where applicable (auth, scanner, profile). Shared infrastructure in `lib/core/` (constants, theme, router, widgets, services).

## State management

**Riverpod** (`ConsumerWidget`, `ProviderScope`, feature providers). Auth state drives **go_router** redirects: unauthenticated users are sent to login; authenticated users leave login for home.

## Navigation

**go_router** with `CustomTransitionPage` (fade, scale, slide) per route. Route paths live in `RouteConstants`. Initial location is login; splash route exists but is not the `initialLocation` in the current router config.

## Data flow

- **Auth:** `AuthRepository` performs HTTP POST login, persists user fields to `SharedPreferences` via `StorageKeys`.
- **Scanner:** `ScannerRepository` uses `Supabase.instance.client.rpc(...)` with `p_vendor_id` / `p_scanner_id` from preferences; maintains in-memory history synced to preferences as JSON.
- **Models:** `UserModel` uses Freezed/JSON codegen; `ScanResult` and related scanner entities support serialization for history.

## Configuration

`AppConfig` exposes compile-time overrides via `String.fromEnvironment` / `bool.fromEnvironment`. `main.dart` currently calls `Supabase.initialize` with literal URL/key; keep in sync with `AppConfig` or migrate initialization to use `AppConfig` + `--dart-define` for production hygiene.

## Feedback

`HapticFeedback` helpers, `vibration`, `audioplayers` via centralized `AudioService` initialized with prefs in `main`.
