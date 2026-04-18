# Project brief

## Name

**tpc_ops** — TPC Operations / ticket scanning (Flutter).

## Purpose

Provide a field-ready mobile app for scanner members: authenticate against the vendor portal API, validate event tickets via QR or manual entry, record outcomes, and review scan history. Ticket validation is backed by Supabase RPCs (`verify_and_use_ticket`, `verify_ticket_by_number`).

## Scope

- In scope: login/logout, session persistence (SharedPreferences), QR scan (mobile_scanner), manual ticket number entry, local scan history with stats, profile, theming, haptic/audio feedback.
- Backend integration: HTTP login to vendor **`VENDOR_PORTAL_ORIGIN`** (`/api/scanner-members/*`); **Supabase RPCs** (`verify_and_use_ticket`, etc.) via **`tpc-backend-go`** at **`SUPABASE_BFF_URL`** / **`API_BASE_URL`** (same BFF as web clients). Scan history stored locally.

## Success criteria

- Reliable login against the vendor verify-login endpoint.
- Correct handling of valid / invalid / already-scanned ticket responses from Supabase.
- App runs on iOS and Android with clear permissions and stable scanner UX.

## Repository

Path: `tpc-ops-flutter`. Package name in `pubspec.yaml`: `tpc_ops`.
