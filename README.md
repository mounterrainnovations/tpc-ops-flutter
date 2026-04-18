# TPC Ops (Flutter)

Mobile operations app for **TPC / Trippe Chalo** staff: scanner member login, QR ticket scanning, manual ticket entry, scan history, and profile. **Supabase** is reached only via **`tpc-backend-go`** (same URLs as the JS client: `/auth`, `/rest/v1`, `/storage/v1`). Scanner member login still uses the vendor portal’s legacy `/api/*` routes — see `lib/core/constants/app_config.dart` (`VENDOR_PORTAL_ORIGIN`, default `http://localhost:5175`).

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) stable channel (Dart SDK `>=3.0.0 <4.0.0` per `pubspec.yaml`)
- Xcode (iOS) and/or Android Studio / Android SDK (Android)
- Optional: [FVM](https://fvm.app/) if you pin Flutter versions per project

Install Flutter, then confirm toolchains (SDK, licenses, Xcode / CocoaPods) are ready:

```bash
flutter doctor -v
```

If you use Android command-line tools or `sdkmanager` outside Android Studio, set `ANDROID_HOME` to your SDK (often `~/Library/Android/sdk`) and put `platform-tools` and `cmdline-tools/latest/bin` on your `PATH` if needed.

## Full stack local setup

The app talks to **`tpc-backend-go`** for Auth/REST/RPC (`SUPABASE_BFF_URL`) and optionally to the **vendor portal** origin for scanner-member login (`VENDOR_PORTAL_ORIGIN`). Start dependencies in this order:

1. **`tpc-backend-go`** (database + migrations + API):
   ```bash
   cd /path/to/tpc-backend-go
   make dev-db-ready    # Docker Postgres + all goose migrations (see that repo’s README)
   make run-api         # http://localhost:3000 — verify /health
   ```
2. **Vendor portal** (if you use real `/api/scanner-members/*` flows against the Vite dev server):
   ```bash
   cd /path/to/tpc-vendor-portal
   npm install && npm run dev    # default http://localhost:5175
   ```
3. **This app** — from repo root:
   ```bash
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   flutter run
   ```

If **`tpc-backend-go`** is not running, network calls will fail (e.g. connection refused). Details: **[tpc-backend-go README — Local setup](../tpc-backend-go/README.md#local-setup-step-by-step)**.

## Local setup

From the repo root:

```bash
cd /path/to/tpc-ops-flutter
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Regenerate code when you change `freezed` / `json_serializable` / Riverpod-annotated sources:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Run the app

```bash
flutter run
```

Pick a device or simulator when prompted.

### Tests and analysis

```bash
flutter analyze
flutter test
```

On recent Flutter SDKs, `flutter analyze` may exit non-zero while only reporting **info**-level lints (for example deprecated `Color.withOpacity`). Use `flutter analyze --no-fatal-infos` if you want a green exit until those are migrated.

## Assets

`pubspec.yaml` declares:

- `assets/images/`
- `assets/animations/`
- `assets/sounds/`
- `assets/icon/` (placeholder via `.gitkeep`; add real media before release)

For launcher icons, `flutter_launcher_icons` expects `assets/icon/app_icon.png`. Add that file (or adjust `pubspec.yaml`) before running:

```bash
dart run flutter_launcher_icons
```

## Configuration

See `lib/core/constants/app_config.dart`.

- **`API_BASE_URL`** — `tpc-backend-go` (default `http://localhost:3000`).
- **`SUPABASE_BFF_URL`** — must match the Go API origin (same as BFF for Auth/REST/RPC); default `http://localhost:3000`.
- **`SUPABASE_BFF_PLACEHOLDER_KEY`** — public placeholder string; the server replaces the real `apikey` on proxied calls.
- **`VENDOR_PORTAL_ORIGIN`** — vendor app / legacy `/api/scanner-members/*` (default `http://localhost:5175`).

Example:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000 \
  --dart-define=SUPABASE_BFF_URL=http://localhost:3000 \
  --dart-define=VENDOR_PORTAL_ORIGIN=http://localhost:5175
```

Web on port **8080** (optional): `flutter run -d chrome --web-port=8080` with the same defines.

- **Camera:** ensure the app has camera permission on device (see `permission_handler` / platform manifests).

## Project layout (high level)

| Area | Role |
|------|------|
| `lib/core/` | Theme, router, config, shared widgets, services |
| `lib/features/auth/` | Login, splash, auth state (Riverpod) |
| `lib/features/scanner/` | Home, scanner, history, Supabase ticket RPCs |
| `lib/features/profile/` | Profile screen |

Routing uses **go_router** with redirects based on `authProvider` (`lib/core/router/app_router.dart`).

## Mock QR codes

`mock_qr_codes.html` in the repo root can help test scanner flows in development.

## Memory bank

Agent/session context for this repo lives in `memory-bank/` (see `memory-bank/projectbrief.md`).
