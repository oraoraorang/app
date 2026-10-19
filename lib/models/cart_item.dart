import 'product.dart';

/// One line of the cart: a product and how many of it were added.
class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get subtotal => product.price * quantity;
}
