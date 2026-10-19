import 'package:flutter/material.dart';

import '../routes.dart';
import '../state/cart_scope.dart';

/// AppBar cart icon with a badge that shows how many items are in the cart.
class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final int count = CartScope.of(context).totalCount;

    return IconButton(
      tooltip: 'Cart',
      onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
