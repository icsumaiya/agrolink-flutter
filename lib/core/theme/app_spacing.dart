/// Spacing, radius and size tokens. Never hardcode these in widgets.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;

  /// Minimum tap target size (accessibility).
  static const double minTapTarget = 48;

  /// Max content width so layouts stay tidy on tablets.
  static const double maxContentWidth = 600;
}