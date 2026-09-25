/// Central route names. Screens are pushed via named routes so guards
/// (Section 2 of the project spec) run in one place, not per-button.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const settings = '/settings';

  static const buyerHome = '/buyer';
  static const buyerWishlist = '/buyer/wishlist';
  static const buyerOrderRequest = '/buyer/order-request';

  static const farmerDashboard = '/farmer';
  static const farmerAddProduct = '/farmer/add-product';
  static const farmerEditProduct = '/farmer/edit-product';
  static const farmerMyProducts = '/farmer/my-products';
  static const farmerIncomingOrders = '/farmer/incoming-orders';
}