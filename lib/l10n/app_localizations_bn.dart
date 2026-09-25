// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'এগ্রোলিংক';

  @override
  String get tagline => 'কৃষক ও ক্রেতার সংযোগ';

  @override
  String get settings => 'সেটিংস';

  @override
  String get language => 'ভাষা';

  @override
  String get theme => 'থিম';

  @override
  String get darkMode => 'ডার্ক মোড';

  @override
  String get english => 'English';

  @override
  String get bangla => 'বাংলা';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get showPassword => 'পাসওয়ার্ড দেখান';

  @override
  String get hidePassword => 'পাসওয়ার্ড লুকান';

  @override
  String get available => 'পাওয়া যাচ্ছে';

  @override
  String get outOfStock => 'স্টক শেষ';

  @override
  String get login => 'লগ ইন';

  @override
  String get logout => 'লগ আউট';

  @override
  String get createAccount => 'অ্যাকাউন্ট তৈরি করুন';

  @override
  String get welcomeBack => 'স্বাগতম';

  @override
  String get loginSubtitle => 'চালিয়ে যেতে লগ ইন করুন';

  @override
  String get registerSubtitle => 'কৃষক বা ক্রেতা হিসেবে এগ্রোলিংকে যোগ দিন';

  @override
  String get email => 'ইমেইল';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get fullName => 'পূর্ণ নাম';

  @override
  String get phone => 'ফোন নম্বর';

  @override
  String get iAmA => 'আমি একজন';

  @override
  String get farmer => 'কৃষক';

  @override
  String get buyer => 'ক্রেতা';

  @override
  String get roleLockedNote =>
      'নিবন্ধনের পর আপনার ভূমিকা পরিবর্তন করা যাবে না।';

  @override
  String get noAccountYet => 'অ্যাকাউন্ট নেই?';

  @override
  String get haveAccount => 'ইতিমধ্যে অ্যাকাউন্ট আছে?';

  @override
  String get register => 'নিবন্ধন';

  @override
  String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন?';

  @override
  String get forgotPasswordHint => 'আপনার ইমেইল দিন, আমরা রিসেট লিংক পাঠাব।';

  @override
  String get sendResetLink => 'রিসেট লিংক পাঠান';

  @override
  String get forgotPasswordDemo =>
      'শুধু ডেমো: এই সংস্করণে কোনো ইমেইল পাঠানো হয় না।';

  @override
  String get registrationDemoNote =>
      'ফর্ম সঠিক। অ্যাকাউন্ট সংরক্ষণ Phase 2-এ যোগ হবে।';

  @override
  String get fieldRequired => 'এই ঘরটি পূরণ করা আবশ্যক';

  @override
  String get invalidEmail => 'সঠিক ইমেইল ঠিকানা দিন';

  @override
  String get invalidPhone => 'সঠিক ফোন নম্বর দিন';

  @override
  String get passwordTooShort => 'পাসওয়ার্ড কমপক্ষে 6 অক্ষরের হতে হবে';

  @override
  String get passwordsDoNotMatch => 'পাসওয়ার্ড মিলছে না';

  @override
  String get roleRequired => 'একটি ভূমিকা নির্বাচন করুন';

  @override
  String get invalidCredentials => 'ইমেইল বা পাসওয়ার্ড ভুল';

  @override
  String welcomeUser(String name) {
    return 'স্বাগতম, $name!';
  }

  @override
  String get homeComingSoon => 'হোম স্ক্রিন পরের ধাপে যোগ হবে।';

  @override
  String get featuredProducts => 'বাছাইকৃত পণ্য';

  @override
  String get categories => 'ক্যাটাগরি';

  @override
  String get recentlyViewed => 'সম্প্রতি দেখা';

  @override
  String get allProducts => 'সব পণ্য';

  @override
  String get searchProducts => 'পণ্য খুঁজুন';

  @override
  String get noProductsFound => 'কোনো পণ্য পাওয়া যায়নি';

  @override
  String get noProductsHint => 'ভিন্ন কিছু খুঁজুন বা ক্যাটাগরি বদলান';

  @override
  String get productDetails => 'পণ্যের বিবরণ';

  @override
  String get farmerInfo => 'কৃষক';

  @override
  String get callFarmer => 'কৃষককে কল করুন';

  @override
  String get sendOrderRequest => 'অর্ডার রিকোয়েস্ট পাঠান';

  @override
  String get reviews => 'রিভিউ';

  @override
  String get noReviewsYet => 'এখনো কোনো রিভিউ নেই';

  @override
  String get sold => 'বিক্রি হয়েছে';

  @override
  String get description => 'বিবরণ';

  @override
  String get location => 'অবস্থান';

  @override
  String get addedToWishlist => 'উইশলিস্টে যোগ হয়েছে';

  @override
  String get removedFromWishlist => 'উইশলিস্ট থেকে সরানো হয়েছে';

  @override
  String get comingSoonFeature => 'এই সুবিধা Phase 2-এ যোগ হবে।';

  @override
  String get categoryVegetables => 'সবজি';

  @override
  String get categoryFruits => 'ফল';

  @override
  String get categoryRice => 'চাল';

  @override
  String get categoryFish => 'মাছ';

  @override
  String get categoryMeat => 'মাংস';

  @override
  String get categoryGrains => 'শস্য';

  @override
  String get categorySpices => 'মসলা';

  @override
  String get categoryOther => 'অন্যান্য';

  @override
  String get dashboard => 'ড্যাশবোর্ড';

  @override
  String get totalProducts => 'মোট পণ্য';

  @override
  String get activeProducts => 'সক্রিয় পণ্য';

  @override
  String get pendingOrders => 'অপেক্ষমাণ অর্ডার';

  @override
  String get completedOrders => 'সম্পন্ন অর্ডার';

  @override
  String get topSellingProducts => 'সর্বাধিক বিক্রিত পণ্য';

  @override
  String get unitsSold => 'ইউনিট বিক্রি';

  @override
  String get inStock => 'স্টকে আছে';

  @override
  String get myProducts => 'আমার পণ্য';

  @override
  String get noProductsYet => 'এখনো কোনো পণ্য নেই';

  @override
  String get noProductsYetHint => 'আপনার যোগ করা পণ্য এখানে দেখাবে।';

  @override
  String get addProduct => 'পণ্য যোগ করুন';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get editProfile => 'প্রোফাইল সম্পাদনা';

  @override
  String get about => 'বিবরণ';

  @override
  String get memberSince => 'সদস্য হয়েছেন';
}
