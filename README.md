# AgroLink – Smart Agricultural Marketplace

A Flutter mobile app that connects farmers and buyers through a simple agricultural marketplace.
Semester project, BSc in Software Engineering.

**Current version:** AgroLink v0.1.0 (Phase 1: Project Setup, UI and Navigation)

## Problem Statement

Farmers often find it hard to reach buyers and present their products in an organized way.
Buyers, on the other hand, find it hard to discover available products, compare prices,
check availability and get information about farmers. AgroLink provides a simple platform
where farmers manage their products and orders, and buyers discover products and send
order requests.

## Target Users

- **Farmers:** manage profile, products and incoming orders, and view sales information.
- **Buyers:** browse and search products, save a wishlist, send order requests, track
  orders, and rate and review completed orders.

## Features Implemented in Phase 1

- Splash, Login, Registration (with farmer/buyer role selection) and Forgot Password screens
- Form validation with localized messages (email, phone, password, confirm password, role)
- Role-based navigation: separate bottom-navigation shells for Buyer and Farmer
- Route guard that blocks a user from opening another role's screens
- Buyer Home (categories, featured products), Product List (search and category filter)
- Product Details with image gallery (swipe and thumbnails), rating, farmer info and reviews
- Farmer Dashboard with statistics and Top Selling Products calculated from sample data
- My Products (shows only the logged-in farmer's products) and Profile screens
- Light and Dark theme, English and Bangla localization, switchable from Settings
- Design system (colors, spacing, text styles) and reusable widgets
- Missing or invalid images fall back to a placeholder instead of crashing
- Data models and sample data that match the planned Hive storage design

## Planned for Phase 2 (not implemented yet)

Hive storage, real registration and duplicate-email check, add/edit/delete products with
ownership rules, full search/filter/sort, wishlist, order requests with stock management,
mock bKash and Cash on Delivery payment, reviews, maps, Call Farmer, and saving the theme
and language settings.

## Technology Stack

- Flutter and Dart
- State management: Provider
- Local storage (Phase 2): Hive
- Maps (Phase 2): flutter_map with OpenStreetMap
- Localization: flutter_localizations and intl (English, Bangla)

## Folder Structure

```
lib/
  core/          theme, routing
  models/        AppUser, Product, Order, Review, enums
  providers/     AuthProvider, SettingsProvider
  screens/       auth/, buyer/, farmer/, common/
  widgets/       shared reusable components
  utils/         validators, feedback helper, category labels
  data/          sample data
  l10n/          app_en.arb, app_bn.arb
```

## Architecture

```
UI / Screens -> Provider -> Repository -> Hive -> Local Data
```

Planned future path:

```
UI / Screens -> Provider -> Repository -> REST API -> Backend -> Database
```

In Phase 1 the repository and Hive layers are not added yet. Screens read from sample data
through providers.

## How to Run

```
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

To run on an Android device or emulator, use `flutter run` instead.

## Demo Accounts

| Role   | Email                  | Password |
|--------|------------------------|----------|
| Farmer | farmer1@agrolink.demo  | demo1234 |
| Farmer | farmer2@agrolink.demo  | demo1234 |
| Buyer  | buyer1@agrolink.demo   | demo1234 |
| Buyer  | buyer2@agrolink.demo   | demo1234 |

Accounts created through the Register screen are not saved in Phase 1.

## Testing

Unit and widget tests cover data models, form validators, login logic and the role-based
route guard.

```
flutter test
```

## Screenshots

To be added in Phase 3.

## Future Scope

Real backend with REST API and database, admin dashboard, real payment gateway, in-app chat,
multi-item cart, push notifications, delivery tracking, farmer replies to reviews, and
ML/AI features such as crop price prediction and plant disease detection.

## Version

AgroLink v0.1.0, Semester Project, BSc in Software Engineering.