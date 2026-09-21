import 'enums.dart';

/// App user (farmer or buyer). Named AppUser to avoid clashing with
/// backend "User" classes when Firebase/REST is added later.
class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.createdAt,
    this.imagePath,
    this.location = '',
    this.latitude,
    this.longitude,
    this.about = '',
  });

  final String id;
  final String name;
  final String email;

  /// MOCK AUTH ONLY (coursework): stored in local storage, never in UI code.
  /// A real backend would store a salted hash server-side instead.
  final String password;

  final String phone;
  final UserRole role;
  final DateTime createdAt;
  final String? imagePath;
  final String location; // text; mainly for farmers
  final double? latitude; // farmer map location
  final double? longitude;
  final String about; // basic farming-related info

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role.name,
        'createdAt': createdAt.toIso8601String(),
        'imagePath': imagePath,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'about': about,
      };

  factory AppUser.fromMap(Map<dynamic, dynamic> map) => AppUser(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
        phone: (map['phone'] as String?) ?? '',
        role: enumFromName(UserRole.values, map['role'], UserRole.buyer),
        createdAt: DateTime.parse(map['createdAt'] as String),
        imagePath: map['imagePath'] as String?,
        location: (map['location'] as String?) ?? '',
        latitude: (map['latitude'] as num?)?.toDouble(),
        longitude: (map['longitude'] as num?)?.toDouble(),
        about: (map['about'] as String?) ?? '',
      );
}