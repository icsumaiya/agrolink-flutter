import 'package:agrolink/l10n/app_localizations_en.dart';
import 'package:agrolink/providers/auth_provider.dart';
import 'package:agrolink/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('Validators', () {
    test('required', () {
      expect(Validators.required(l10n, ''), isNotNull);
      expect(Validators.required(l10n, '  '), isNotNull);
      expect(Validators.required(l10n, 'Sumaiya'), isNull);
    });

    test('email', () {
      expect(Validators.email(l10n, 'abc'), isNotNull);
      expect(Validators.email(l10n, 'a@b'), isNotNull);
      expect(Validators.email(l10n, 'a@b.com'), isNull);
    });

    test('phone', () {
      expect(Validators.phone(l10n, '12345'), isNotNull);
      expect(Validators.phone(l10n, '01712345678'), isNull);
      expect(Validators.phone(l10n, '+8801712345678'), isNull);
    });

    test('password length and confirm', () {
      expect(Validators.password(l10n, '12345'), isNotNull);
      expect(Validators.password(l10n, '123456'), isNull);
      expect(Validators.confirmPassword(l10n, 'abc', 'abd'), isNotNull);
      expect(Validators.confirmPassword(l10n, 'abc', 'abc'), isNull);
    });
  });

  group('AuthProvider (Phase 1 in-memory)', () {
    test('valid login sets the current user', () {
      final auth = AuthProvider();
      expect(auth.login('buyer1@agrolink.demo', 'demo1234'), isTrue);
      expect(auth.isLoggedIn, isTrue);
      expect(auth.currentUser?.email, 'buyer1@agrolink.demo');
    });

    test('email is case-insensitive and trimmed', () {
      final auth = AuthProvider();
      expect(auth.login('  FARMER1@agrolink.demo ', 'demo1234'), isTrue);
    });

    test('wrong password or unknown email fails', () {
      final auth = AuthProvider();
      expect(auth.login('buyer1@agrolink.demo', 'wrong'), isFalse);
      expect(auth.login('nobody@agrolink.demo', 'demo1234'), isFalse);
      expect(auth.isLoggedIn, isFalse);
    });

    test('logout clears the user', () {
      final auth = AuthProvider()..login('buyer1@agrolink.demo', 'demo1234');
      auth.logout();
      expect(auth.currentUser, isNull);
    });
  });
}