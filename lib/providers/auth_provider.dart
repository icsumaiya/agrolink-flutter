import 'package:flutter/foundation.dart';

import '../data/sample_data.dart';
import '../models/app_user.dart';

/// Phase 1: checks the in-memory sample users.
/// Phase 2: the same methods will call AuthRepository (Hive), so screens
/// won't change.
class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Returns false for any wrong email/password (one generic error on purpose).
  bool login(String email, String password) {
    final e = email.trim().toLowerCase();
    for (final u in SampleData.users) {
      if (u.email.toLowerCase() == e && u.password == password) {
        _currentUser = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}