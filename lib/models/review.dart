/// Public review: reviewer name is shown to everyone (not anonymous).
/// One review per completed order (orderId).
class Review {
  const Review({
    required this.id,
    required this.buyerId,
    required this.buyerDisplayName,
    required this.productId,
    required this.orderId,
    required this.rating,
    required this.createdAt,
    this.comment = '',
  });

  final String id;
  final String buyerId;

  /// Denormalized at write time so the name still shows if buyer data changes.
  final String buyerDisplayName;

  final String productId;
  final String orderId;
  final int rating; // 1-5
  final String comment; // optional, length-limited in the form
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'buyerId': buyerId,
        'buyerDisplayName': buyerDisplayName,
        'productId': productId,
        'orderId': orderId,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Review.fromMap(Map<dynamic, dynamic> map) => Review(
        id: map['id'] as String,
        buyerId: map['buyerId'] as String,
        buyerDisplayName: map['buyerDisplayName'] as String,
        productId: map['productId'] as String,
        orderId: map['orderId'] as String,
        rating: map['rating'] as int,
        comment: (map['comment'] as String?) ?? '',
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
}