import 'package:agrolink/data/sample_data.dart';
import 'package:agrolink/models/enums.dart';
import 'package:agrolink/models/order.dart';
import 'package:agrolink/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Product survives toMap/fromMap', () {
    final p = SampleData.products.first;
    final copy = Product.fromMap(p.toMap());
    expect(copy.id, p.id);
    expect(copy.price, p.price);
    expect(copy.category, p.category);
    expect(copy.createdAt, p.createdAt);
  });

  test('Order survives toMap/fromMap', () {
    final o = SampleData.orders.last;
    final copy = Order.fromMap(o.toMap());
    expect(copy.status, o.status);
    expect(copy.paymentMethod, o.paymentMethod);
    expect(copy.totalPrice, o.totalPrice);
  });

  test('Availability is derived from quantity', () {
    final fish = SampleData.products.firstWhere((p) => p.id == 'p5');
    expect(fish.isAvailable, isFalse);
  });

  test('Rating and totalSold are computed, not hardcoded', () {
    final tomato = SampleData.products.firstWhere((p) => p.id == 'p1');
    expect(tomato.reviewCount, 2);
    expect(tomato.averageRating, 4.5);
    expect(tomato.totalSold, 30); // two completed orders: 10 + 20
  });

  test('Accepted/pending orders do not count as sold', () {
    final turmeric = SampleData.products.firstWhere((p) => p.id == 'p7');
    expect(turmeric.totalSold, 0);
  });

  test('Every order references an existing product and users', () {
    final productIds = SampleData.products.map((p) => p.id).toSet();
    for (final o in SampleData.orders) {
      expect(productIds.contains(o.productId), isTrue);
      expect(SampleData.userById(o.buyerId)?.role, UserRole.buyer);
      expect(SampleData.userById(o.farmerId)?.role, UserRole.farmer);
    }
  });
}