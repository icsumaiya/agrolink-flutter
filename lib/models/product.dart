import 'enums.dart';

class Product {
  const Product({
    required this.id,
    required this.farmerId,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.createdAt,
    this.imagePath,
    this.isActive = true,
    this.averageRating = 0,
    this.reviewCount = 0,
    this.totalSold = 0,
  });

  final String id;
  final String farmerId; // ownership: only this farmer may edit/delete
  final String name;
  final ProductCategory category;
  final double price;
  final int quantity;
  final String unit;
  final String location;
  final double latitude;
  final double longitude;
  final String description;
  final DateTime createdAt;
  final String? imagePath; // local file path or null -> placeholder

  /// Soft-delete flag: false hides the product from buyers but keeps it
  /// referenced by past orders (order history + analytics keep working).
  final bool isActive;

  // COMPUTED by the repository from reviews/orders. Never persisted.
  final double averageRating;
  final int reviewCount;
  final int totalSold;

  /// Availability is automatic: never toggled manually.
  bool get isAvailable => quantity > 0;

  /// id, farmerId and createdAt are intentionally not changeable.
  Product copyWith({
    String? name,
    ProductCategory? category,
    double? price,
    int? quantity,
    String? unit,
    String? location,
    double? latitude,
    double? longitude,
    String? description,
    String? imagePath,
    bool? isActive,
    double? averageRating,
    int? reviewCount,
    int? totalSold,
  }) =>
      Product(
        id: id,
        farmerId: farmerId,
        createdAt: createdAt,
        name: name ?? this.name,
        category: category ?? this.category,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        description: description ?? this.description,
        imagePath: imagePath ?? this.imagePath,
        isActive: isActive ?? this.isActive,
        averageRating: averageRating ?? this.averageRating,
        reviewCount: reviewCount ?? this.reviewCount,
        totalSold: totalSold ?? this.totalSold,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'farmerId': farmerId,
        'name': name,
        'category': category.name,
        'price': price,
        'quantity': quantity,
        'unit': unit,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'imagePath': imagePath,
        'isActive': isActive,
      };

  factory Product.fromMap(Map<dynamic, dynamic> map) => Product(
        id: map['id'] as String,
        farmerId: map['farmerId'] as String,
        name: map['name'] as String,
        category: enumFromName(
          ProductCategory.values,
          map['category'],
          ProductCategory.other,
        ),
        price: (map['price'] as num).toDouble(),
        quantity: map['quantity'] as int,
        unit: map['unit'] as String,
        location: map['location'] as String,
        latitude: (map['latitude'] as num).toDouble(),
        longitude: (map['longitude'] as num).toDouble(),
        description: map['description'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        imagePath: map['imagePath'] as String?,
        isActive: (map['isActive'] as bool?) ?? true,
      );
}