import 'enums.dart';

/// Single-product order request (no cart in this version).
class Order {
  const Order({
    required this.id,
    required this.buyerId,
    required this.farmerId,
    required this.productId,
    required this.productName,
    required this.unit,
    required this.quantity,
    required this.totalPrice,
    required this.orderDate,
    required this.deliveryLocation,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    this.paymentStatus = PaymentStatus.payOnDelivery,
    this.isRated = false,
  });

  final String id;
  final String buyerId; // ownership: only this buyer sees/cancels it
  final String farmerId; // ownership: only this farmer manages it
  final String productId;

  /// Snapshots so history stays correct even if the product changes/soft-deletes.
  final String productName;
  final String unit;

  final int quantity;

  /// quantity x product price AT ORDER TIME (price may change later).
  final double totalPrice;

  final DateTime orderDate;
  final String deliveryLocation;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final bool isRated; // controls the "Rate this order" button

  Order copyWith({
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    bool? isRated,
  }) =>
      Order(
        id: id,
        buyerId: buyerId,
        farmerId: farmerId,
        productId: productId,
        productName: productName,
        unit: unit,
        quantity: quantity,
        totalPrice: totalPrice,
        orderDate: orderDate,
        deliveryLocation: deliveryLocation,
        paymentMethod: paymentMethod,
        status: status ?? this.status,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        isRated: isRated ?? this.isRated,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'buyerId': buyerId,
        'farmerId': farmerId,
        'productId': productId,
        'productName': productName,
        'unit': unit,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'orderDate': orderDate.toIso8601String(),
        'deliveryLocation': deliveryLocation,
        'paymentMethod': paymentMethod.name,
        'status': status.name,
        'paymentStatus': paymentStatus.name,
        'isRated': isRated,
      };

  factory Order.fromMap(Map<dynamic, dynamic> map) => Order(
        id: map['id'] as String,
        buyerId: map['buyerId'] as String,
        farmerId: map['farmerId'] as String,
        productId: map['productId'] as String,
        productName: map['productName'] as String,
        unit: map['unit'] as String,
        quantity: map['quantity'] as int,
        totalPrice: (map['totalPrice'] as num).toDouble(),
        orderDate: DateTime.parse(map['orderDate'] as String),
        deliveryLocation: (map['deliveryLocation'] as String?) ?? '',
        paymentMethod: enumFromName(
          PaymentMethod.values,
          map['paymentMethod'],
          PaymentMethod.cashOnDelivery,
        ),
        status: enumFromName(
          OrderStatus.values,
          map['status'],
          OrderStatus.pending,
        ),
        paymentStatus: enumFromName(
          PaymentStatus.values,
          map['paymentStatus'],
          PaymentStatus.payOnDelivery,
        ),
        isRated: (map['isRated'] as bool?) ?? false,
      );
}