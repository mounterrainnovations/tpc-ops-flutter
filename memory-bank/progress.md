# Progress

## Working (as designed in codebase)

- App shell: `MaterialApp.router`, light/dark themes (mode fixed to light in `main`).
- Auth flow: vendor HTTP login, persisted session, logout clearing keys.
- Scanner: QR validation via `verify_and_use_ticket`, manual entry via `verify_ticket_by_number`.
- History persisted locally; stats helpers for valid/invalid/duplicate/today counts.
- Profile screen; routing with auth redirects.

## Local / repo hygiene

- README documents **full stack** ( **`tpc-backend-go`** migrations + API, optional **vendor portal**, then Flutter).
- Memory bank + `.gitkeep` assets; **Setup verified:** `flutter pub get`, `build_runner`, `flutter test` with Flutter + mobile toolchains.

## Outstanding / verify

- App icon file may be missing — confirm before `flutter_launcher_icons`.
- Align Supabase init in `main.dart` with `AppConfig` and production secret handling.

## Known technical debt

- `flutter analyze` still reports **info**-level issues (e.g. `Color.withOpacity` deprecation on newer Flutter); optional cleanup to use `.withValues()` / `activeThumbColor`.
- `main.dart` Supabase URL/key literals may differ from `AppConfig` default JWT suffix; unify to avoid drift.
- `initialLocation` is login; splash route exists — confirm product intent for cold start.
