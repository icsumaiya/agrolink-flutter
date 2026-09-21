/// Reads an enum back from its stored name; falls back if missing/unknown.
T enumFromName<T extends Enum>(List<T> values, Object? name, T fallback) {
  for (final v in values) {
    if (v.name == name) return v;
  }
  return fallback;
}

/// Locked at registration; never changes for an account.
enum UserRole { farmer, buyer }

enum ProductCategory {
  vegetables,
  fruits,
  rice,
  fish,
  meat,
  grains,
  spices,
  other,
}

enum OrderStatus {
  pending,
  accepted,
  rejected,
  preparing,
  completed,
  cancelled,
}

enum PaymentMethod { bkash, cashOnDelivery }

/// payOnDelivery -> paidCash happens automatically when a COD order completes.
/// paid / paymentFailed come only from the mock bKash flow (demo only).
enum PaymentStatus { payOnDelivery, paid, paidCash, paymentFailed }