# TPC Ops (Flutter)

Mobile operations app for **TPC / Trippe Chalo** staff: scanner member login, QR ticket scanning, manual ticket entry, scan history, and profile. Auth talks to the vendor HTTP API; ticket validation uses **Supabase** RPCs.

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) stable channel (Dart SDK `>=3.0.0 <4.0.0` per `pubspec.yaml`)
- Xcode (iOS) and/or Android Studio / Android SDK (Android)
- Optional: [FVM](https://fvm.app/) if you pin Flutter versions per project

Install Flutter, then confirm toolchains (SDK, licenses, Xcode / CocoaPods) are ready:

```bash
flutter doctor -v
```

If you use Android command-line tools or `sdkmanager` outside Android Studio, set `ANDROID_HOME` to your SDK (often `~/Library/Android/sdk`) and put `platform-tools` and `cmdline-tools/latest/bin` on your `PATH` if needed.

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

- **Vendor API (login):** default base URL is `https://vendor.trippechalo.in`. Override at build/run time with Dart defines, for example:

  ```bash
  flutter run --dart-define=API_BASE_URL=https://your-api.example
  ```

  See `lib/core/constants/app_config.dart` for `API_BASE_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`, and `PRODUCTION`.

- **Supabase:** `lib/main.dart` initializes Supabase at startup. Prefer aligning URL/key with `AppConfig` and passing values via `--dart-define` for non-commit secrets in production.

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
