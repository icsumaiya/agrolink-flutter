import 'package:flutter/material.dart';

/// Holds theme mode + language. In Phase 2 this will load/save via
/// SettingsRepository (Hive) so the choice survives an app restart.
class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isDark => _themeMode == ThemeMode.dark;

  void setDarkMode(bool value) {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLanguage(String languageCode) {
    if (_locale.languageCode == languageCode) return;
    _locale = Locale(languageCode);
    notifyListeners();
  }
}