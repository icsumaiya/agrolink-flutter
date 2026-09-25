// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'AgroLink';

  @override
  String get tagline => 'Connecting farmers and buyers';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get english => 'English';

  @override
  String get bangla => 'বাংলা';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get available => 'Available';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get login => 'Log in';

  @override
  String get logout => 'Log out';

  @override
  String get createAccount => 'Create account';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to continue';

  @override
  String get registerSubtitle => 'Join AgroLink as a farmer or buyer';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get fullName => 'Full name';

  @override
  String get phone => 'Phone number';

  @override
  String get iAmA => 'I am a';

  @override
  String get farmer => 'Farmer';

  @override
  String get buyer => 'Buyer';

  @override
  String get roleLockedNote =>
      'Your role cannot be changed after registration.';

  @override
  String get noAccountYet => 'Don\'t have an account?';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get register => 'Register';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordHint =>
      'Enter your email and we\'ll send a reset link.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get forgotPasswordDemo =>
      'Demo only: no email is sent in this version.';

  @override
  String get registrationDemoNote =>
      'Form is valid. Saving accounts is added in Phase 2.';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get invalidPhone => 'Enter a valid phone number';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get roleRequired => 'Please select a role';

  @override
  String get invalidCredentials => 'Invalid email or password';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get homeComingSoon => 'The home screen is added in the next step.';
}
