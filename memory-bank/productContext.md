# Product context

## Problem

Event operations need a fast way to confirm tickets at entry: scan QR payloads signed for verification, fall back to manual lookup, and see recent scans without losing context when the app restarts.

## Users

Scanner members (vendor-affiliated staff) who log in with username/password issued for the vendor portal.

## Experience goals

- Short path from login to scan; home hub with navigation to scanner, history, profile.
- Immediate feedback: animations, haptics, optional sounds via `AudioService`.
- Clear distinction between valid, duplicate, and invalid tickets with attendee and event details when available.

## Related systems

- **Vendor API** (`/api/scanner-members/verify-login`): session establishment and user/vendor metadata stored locally.
- **Supabase**: RPCs receive QR data, signature, scanner id, vendor id, notes; returns structured status for UI mapping to `ScanResult` variants.
