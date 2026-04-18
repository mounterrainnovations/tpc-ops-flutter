/// Application Configuration
/// This file contains environment-specific configuration values
class AppConfig {
  /// tpc-backend-go (events, bookings, BFF). `--dart-define=API_BASE_URL=...` in prod.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  /// Vendor portal origin for legacy `/api/*` routes (e.g. scanner login via Vercel/Node). Not the Go API.
  static const String vendorPortalOrigin = String.fromEnvironment(
    'VENDOR_PORTAL_ORIGIN',
    defaultValue: 'http://localhost:5175',
  );

  /// Supabase JS-compatible base URL: must be the Go BFF root (same host as API), not a project URL.
  static const String supabaseBffUrl = String.fromEnvironment(
    'SUPABASE_BFF_URL',
    defaultValue: 'http://localhost:3000',
  );

  /// Not secret — the Go server sets `apikey` on proxied REST/Auth/Storage calls.
  static const String supabaseBffPlaceholderKey = String.fromEnvironment(
    'SUPABASE_BFF_PLACEHOLDER_KEY',
    defaultValue: 'sb-bff-client-placeholder',
  );

  // Environment
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );

  // Debug mode
  static bool get isDebugMode => !isProduction;
}
