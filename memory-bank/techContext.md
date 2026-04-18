# Tech context

## Stack

- **Flutter** / **Dart** `>=3.0.0 <4.0.0`
- **flutter_riverpod**, **riverpod_annotation** (+ generator in dev_dependencies)
- **go_router** for routing
- **supabase_flutter** for ticket RPCs
- **mobile_scanner** for QR
- **http** for vendor login API
- **shared_preferences** for session and scan history persistence
- **freezed** / **json_serializable** / **build_runner** for codegen
- **permission_handler**, **google_fonts**, **flutter_animate**, **lottie**, **intl**, **uuid**, etc.

## Tooling

- Linting: `flutter_lints` via `analysis_options.yaml`
- Icons/splash: `flutter_launcher_icons`, `flutter_native_splash` (configure before running generators)
- Dev: `devtools_options.yaml` present

## Build / run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Optional defines: **`API_BASE_URL`**, **`SUPABASE_BFF_URL`** (match **`tpc-backend-go`**), **`VENDOR_PORTAL_ORIGIN`**, `PRODUCTION` (see `AppConfig`). Local dev: start Go API (**`make run-api`**) after **`make dev-db-ready`**.

## Assets

Directories declared in `pubspec.yaml` under `assets/`; repo includes `.gitkeep` placeholders. `flutter_launcher_icons` expects `assets/icon/app_icon.png` per `pubspec.yaml` — add the image before icon generation.

## Platforms

Android (`com.tpc.tpc_ops` / Kotlin `MainActivity`) and iOS (`Runner`). Network security config present under Android for cleartext/dev considerations — verify for production endpoints.

## Git notes

`.gitignore` excludes generic `*.md` but explicitly allows `README.md` and `memory-bank/*.md` so documentation can be versioned.
