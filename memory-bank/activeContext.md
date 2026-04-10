# Active context

## Current focus (2026-04-10)

Repo is **locally buildable**: dependencies resolved, codegen run, widget smoke test passes.

## Recent changes

- Added `README.md` with prerequisites, commands, configuration, and layout summary.
- Created `memory-bank/` core files aligned with Cursor Memory Bank structure.
- Added `assets/*/.gitkeep` so declared asset paths exist in a fresh clone.
- Updated `.gitignore` with `!README.md` and `!memory-bank/*.md`.
- Ran `flutter pub get` + `build_runner`; fixed analyzer **warnings** in `haptic_feedback.dart`, `scan_result.dart`, `widget_test.dart`.

## Next steps (suggested)

- Run `flutter run` on a device or simulator.
- Add `assets/icon/app_icon.png` (or adjust `flutter_icons` config) before running launcher icon generation.
- Consider initializing Supabase from `AppConfig` + `--dart-define` only, removing duplicated literals in `main.dart`, for a single source of truth and safer key management.

## Environment note

Developer machine has Flutter **3.41.6** / Dart **3.11.4**; `flutter doctor` clean after Android cmdline-tools + licenses and Xcode setup.
