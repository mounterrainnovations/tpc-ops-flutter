# Active context

## Current focus

- **Locally buildable:** `flutter pub get`, `build_runner`, tests pass with toolchains installed.
- **Backend dependency:** **`tpc-backend-go`** must run at **`API_BASE_URL`** / **`SUPABASE_BFF_URL`** (default `http://localhost:3000`) for Auth + REST/RPC — use **`make dev-db-ready`** + **`make run-api`** in that repo first. **`VENDOR_PORTAL_ORIGIN`** (default `http://localhost:5175`) for scanner-member HTTP login to vendor **`/api/*`** when using those flows.
- **README:** **Full stack local setup** section documents order: Go → optional vendor portal → `flutter run`.

## Recent changes

- `README.md` + **`memory-bank/`** aligned with BFF + migration story; `assets/*/.gitkeep`; `.gitignore` exceptions for README / memory-bank.

## Next steps (suggested)

- Run `flutter run` on a device or simulator (with Go API up).
- Add `assets/icon/app_icon.png` (or adjust `flutter_icons` config) before running launcher icon generation.
- Consider initializing Supabase from `AppConfig` + `--dart-define` only, removing duplicated literals in `main.dart`, for a single source of truth and safer key management.

## Environment note

Developer machine has Flutter **3.41.6** / Dart **3.11.4**; `flutter doctor` clean after Android cmdline-tools + licenses and Xcode setup.
