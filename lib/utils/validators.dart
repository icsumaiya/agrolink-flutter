import '../l10n/app_localizations.dart';

/// Form validators returning localized messages (null = valid).
class Validators {
  Validators._();

  static const int minPasswordLength = 6;
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  // Bangladesh mobile: 01XXXXXXXXX, optionally with +88 / 88 prefix.
  static final RegExp _phone = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');

  static String? required(AppLocalizations l10n, String? value) =>
      (value == null || value.trim().isEmpty) ? l10n.fieldRequired : null;

  static String? email(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
    return _email.hasMatch(value.trim()) ? null : l10n.invalidEmail;
  }

  static String? phone(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
    return _phone.hasMatch(cleaned) ? null : l10n.invalidPhone;
  }

  static String? password(AppLocalizations l10n, String? value) {
    if (value == null || value.isEmpty) return l10n.fieldRequired;
    return value.length < minPasswordLength ? l10n.passwordTooShort : null;
  }

  static String? confirmPassword(
    AppLocalizations l10n,
    String? value,
    String original,
  ) {
    if (value == null || value.isEmpty) return l10n.fieldRequired;
    return value == original ? null : l10n.passwordsDoNotMatch;
  }
}