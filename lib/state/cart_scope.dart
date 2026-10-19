import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

/// Gives every screen access to the cart that lives in the root widget's state.
///
/// The cart itself is kept in MiniKatalogApp's State and changed with setState.
/// Pages pushed with Navigator are cached by Flutter and are not rebuilt when the
/// root calls setState, so this InheritedWidget is what tells them to rebuild
/// (for example to update the cart badge).
class CartScope extends InheritedWidget {
  const CartScope({
    super.key,
    required this.items,
    required this.onAdd,
    required this.onDecrease,
    required this.onRemove,
    required this.onClear,
    required super.child,
  });

  final List<CartItem> items;
  final void Function(Product product) onAdd;
  final void Function(Product product) onDecrease;
  final void Function(Product product) onRemove;
  final VoidCallback onClear;

  /// Use inside build(): the widget rebuilds when the cart changes.
  static CartScope of(BuildContext context) {
    final CartScope? scope =
        context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope found above this context');
    return scope!;
  }

  /// Use inside button callbacks: reads the cart without listening to it.
  static CartScope read(BuildContext context) {
    final CartScope? scope =
        context.getInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope found above this context');
    return scope!;
  }

  int get totalCount =>
      items.fold<int>(0, (int sum, CartItem item) => sum + item.quantity);

  double get totalPrice =>
      items.fold<double>(0, (double sum, CartItem item) => sum + item.subtotal);

  int quantityOf(Product product) {
    for (final CartItem item in items) {
      if (item.product.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }

  @override
  bool updateShouldNotify(CartScope oldWidget) => true;
}
