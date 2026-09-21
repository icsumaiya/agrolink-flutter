import '../models/app_user.dart';
import '../models/enums.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/review.dart';

/// Demo data. All names/contacts are fictional.
/// Phase 1: read directly by the UI.
/// Phase 2: seeds the Hive boxes on first launch / "Reset Sample Data".
/// Demo login for every account: password "demo1234".
class SampleData {
  SampleData._();

  static const String demoPassword = 'demo1234';

  static final List<AppUser> users = [
    AppUser(
      id: 'u_farmer_1',
      name: 'Green Valley Farm',
      email: 'farmer1@agrolink.demo',
      password: demoPassword,
      phone: '01700000001',
      role: UserRole.farmer,
      createdAt: DateTime(2026, 6, 1),
      location: 'Sylhet',
      latitude: 24.8949,
      longitude: 91.8687,
      about: 'Vegetables and fruits grown without heavy chemicals.',
    ),
    AppUser(
      id: 'u_farmer_2',
      name: 'Riverbank Farmers',
      email: 'farmer2@agrolink.demo',
      password: demoPassword,
      phone: '01700000002',
      role: UserRole.farmer,
      createdAt: DateTime(2026, 6, 2),
      location: 'Bogura',
      latitude: 24.8465,
      longitude: 89.3776,
      about: 'Rice, grains, spices and river fish.',
    ),
    AppUser(
      id: 'u_buyer_1',
      name: 'Demo Buyer One',
      email: 'buyer1@agrolink.demo',
      password: demoPassword,
      phone: '01800000001',
      role: UserRole.buyer,
      createdAt: DateTime(2026, 6, 3),
      location: 'Zindabazar, Sylhet',
    ),
    AppUser(
      id: 'u_buyer_2',
      name: 'Demo Buyer Two',
      email: 'buyer2@agrolink.demo',
      password: demoPassword,
      phone: '01800000002',
      role: UserRole.buyer,
      createdAt: DateTime(2026, 6, 4),
      location: 'Mirpur, Dhaka',
    ),
  ];

  static final List<Product> _baseProducts = [
    Product(
      id: 'p1',
      farmerId: 'u_farmer_1',
      name: 'Fresh Tomato',
      category: ProductCategory.vegetables,
      price: 45,
      quantity: 120,
      unit: 'kg',
      location: 'Sylhet',
      latitude: 24.8949,
      longitude: 91.8687,
      description: 'Ripe, red tomatoes picked this morning.',
      createdAt: DateTime(2026, 7, 1),
    ),
    Product(
      id: 'p2',
      farmerId: 'u_farmer_1',
      name: 'Green Chili',
      category: ProductCategory.vegetables,
      price: 160,
      quantity: 40,
      unit: 'kg',
      location: 'Sylhet',
      latitude: 24.9000,
      longitude: 91.8600,
      description: 'Spicy green chili, freshly harvested.',
      createdAt: DateTime(2026, 7, 5),
    ),
    Product(
      id: 'p3',
      farmerId: 'u_farmer_1',
      name: 'Pineapple',
      category: ProductCategory.fruits,
      price: 60,
      quantity: 200,
      unit: 'piece',
      location: 'Sylhet',
      latitude: 24.8850,
      longitude: 91.8750,
      description: 'Sweet, juicy pineapples from our hill farm.',
      createdAt: DateTime(2026, 7, 10),
    ),
    Product(
      id: 'p4',
      farmerId: 'u_farmer_2',
      name: 'Miniket Rice',
      category: ProductCategory.rice,
      price: 68,
      quantity: 500,
      unit: 'kg',
      location: 'Bogura',
      latitude: 24.8465,
      longitude: 89.3776,
      description: 'Clean, polished miniket rice. Good for daily meals.',
      createdAt: DateTime(2026, 7, 2),
    ),
    Product(
      id: 'p5',
      farmerId: 'u_farmer_2',
      name: 'Rui Fish',
      category: ProductCategory.fish,
      price: 320,
      quantity: 0, // out of stock -> isAvailable == false
      unit: 'kg',
      location: 'Bogura',
      latitude: 24.8500,
      longitude: 89.3700,
      description: 'Fresh river rui fish. Currently sold out.',
      createdAt: DateTime(2026, 7, 8),
    ),
    Product(
      id: 'p6',
      farmerId: 'u_farmer_2',
      name: 'Masur Dal',
      category: ProductCategory.grains,
      price: 130,
      quantity: 80,
      unit: 'kg',
      location: 'Bogura',
      latitude: 24.8400,
      longitude: 89.3850,
      description: 'Split red lentils, cleaned and sun-dried.',
      createdAt: DateTime(2026, 7, 12),
    ),
    Product(
      id: 'p7',
      farmerId: 'u_farmer_2',
      name: 'Turmeric Powder',
      category: ProductCategory.spices,
      price: 220,
      quantity: 25,
      unit: 'kg',
      location: 'Bogura',
      latitude: 24.8550,
      longitude: 89.3650,
      description: 'Home-ground turmeric, no added color.',
      createdAt: DateTime(2026, 7, 15),
    ),
    Product(
      id: 'p8',
      farmerId: 'u_farmer_2',
      name: 'Himsagar Mango',
      category: ProductCategory.fruits,
      price: 110,
      quantity: 60,
      unit: 'kg',
      location: 'Bogura',
      latitude: 24.8420,
      longitude: 89.3900,
      description: 'Sweet mangoes with very little fiber.',
      createdAt: DateTime(2026, 7, 18),
    ),
  ];

  static final List<Order> orders = [
    Order(
      id: 'o1',
      buyerId: 'u_buyer_1',
      farmerId: 'u_farmer_1',
      productId: 'p1',
      productName: 'Fresh Tomato',
      unit: 'kg',
      quantity: 10,
      totalPrice: 450,
      orderDate: DateTime(2026, 8, 1),
      deliveryLocation: 'Zindabazar, Sylhet',
      paymentMethod: PaymentMethod.cashOnDelivery,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paidCash,
      isRated: true,
    ),
    Order(
      id: 'o2',
      buyerId: 'u_buyer_2',
      farmerId: 'u_farmer_1',
      productId: 'p1',
      productName: 'Fresh Tomato',
      unit: 'kg',
      quantity: 20,
      totalPrice: 900,
      orderDate: DateTime(2026, 8, 3),
      deliveryLocation: 'Mirpur, Dhaka',
      paymentMethod: PaymentMethod.bkash,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paid,
      isRated: true,
    ),
    Order(
      id: 'o3',
      buyerId: 'u_buyer_1',
      farmerId: 'u_farmer_1',
      productId: 'p3',
      productName: 'Pineapple',
      unit: 'piece',
      quantity: 30,
      totalPrice: 1800,
      orderDate: DateTime(2026, 8, 5),
      deliveryLocation: 'Zindabazar, Sylhet',
      paymentMethod: PaymentMethod.bkash,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paid,
      isRated: true,
    ),
    Order(
      id: 'o4',
      buyerId: 'u_buyer_2',
      farmerId: 'u_farmer_2',
      productId: 'p4',
      productName: 'Miniket Rice',
      unit: 'kg',
      quantity: 50,
      totalPrice: 3400,
      orderDate: DateTime(2026, 8, 7),
      deliveryLocation: 'Mirpur, Dhaka',
      paymentMethod: PaymentMethod.cashOnDelivery,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paidCash,
      isRated: true,
    ),
    // Completed but NOT rated yet -> lets you demo "Rate this order".
    Order(
      id: 'o5',
      buyerId: 'u_buyer_1',
      farmerId: 'u_farmer_2',
      productId: 'p5',
      productName: 'Rui Fish',
      unit: 'kg',
      quantity: 5,
      totalPrice: 1600,
      orderDate: DateTime(2026, 8, 9),
      deliveryLocation: 'Zindabazar, Sylhet',
      paymentMethod: PaymentMethod.bkash,
      status: OrderStatus.completed,
      paymentStatus: PaymentStatus.paid,
    ),
    Order(
      id: 'o6',
      buyerId: 'u_buyer_1',
      farmerId: 'u_farmer_1',
      productId: 'p2',
      productName: 'Green Chili',
      unit: 'kg',
      quantity: 5,
      totalPrice: 800,
      orderDate: DateTime(2026, 9, 15),
      deliveryLocation: 'Zindabazar, Sylhet',
      paymentMethod: PaymentMethod.cashOnDelivery,
    ), // pending (defaults)
    Order(
      id: 'o7',
      buyerId: 'u_buyer_2',
      farmerId: 'u_farmer_2',
      productId: 'p7',
      productName: 'Turmeric Powder',
      unit: 'kg',
      quantity: 3,
      totalPrice: 660,
      orderDate: DateTime(2026, 9, 18),
      deliveryLocation: 'Mirpur, Dhaka',
      paymentMethod: PaymentMethod.bkash,
      status: OrderStatus.accepted,
      paymentStatus: PaymentStatus.paid,
    ),
  ];

  static final List<Review> reviews = [
    Review(
      id: 'r1',
      buyerId: 'u_buyer_1',
      buyerDisplayName: 'Demo Buyer One',
      productId: 'p1',
      orderId: 'o1',
      rating: 5,
      comment: 'Fresh and good quality.',
      createdAt: DateTime(2026, 8, 3),
    ),
    Review(
      id: 'r2',
      buyerId: 'u_buyer_2',
      buyerDisplayName: 'Demo Buyer Two',
      productId: 'p1',
      orderId: 'o2',
      rating: 4,
      comment: 'Good price, delivered on time.',
      createdAt: DateTime(2026, 8, 5),
    ),
    Review(
      id: 'r3',
      buyerId: 'u_buyer_1',
      buyerDisplayName: 'Demo Buyer One',
      productId: 'p3',
      orderId: 'o3',
      rating: 5,
      comment: 'Very sweet pineapples.',
      createdAt: DateTime(2026, 8, 7),
    ),
    Review(
      id: 'r4',
      buyerId: 'u_buyer_2',
      buyerDisplayName: 'Demo Buyer Two',
      productId: 'p4',
      orderId: 'o4',
      rating: 4,
      comment: 'Clean rice, well packed.',
      createdAt: DateTime(2026, 8, 9),
    ),
  ];

  /// Products with computed stats, same rules Phase 2 repositories will use:
  /// rating/reviewCount from reviews, totalSold ONLY from Completed orders
  /// (never on Accepted) so analytics are never double-counted.
  static List<Product> get products => _baseProducts.map((p) {
        final productReviews = reviews.where((r) => r.productId == p.id);
        final sold = orders
            .where(
              (o) =>
                  o.productId == p.id && o.status == OrderStatus.completed,
            )
            .fold<int>(0, (sum, o) => sum + o.quantity);
        final ratingSum = productReviews.fold<int>(0, (s, r) => s + r.rating);
        final count = productReviews.length;

        return p.copyWith(
          averageRating: count == 0 ? 0 : ratingSum / count,
          reviewCount: count,
          totalSold: sold,
        );
      }).toList();

  static AppUser? userById(String id) {
    for (final u in users) {
      if (u.id == id) return u;
    }
    return null;
  }
}