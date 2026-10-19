import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_scope.dart';

/// Adds the product to the cart and shows a short confirmation message.
void addToCartWithFeedback(BuildContext context, Product product) {
  CartScope.read(context).onAdd(product);

  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text('${product.name} added to cart'),
      duration: const Duration(seconds: 1),
    ),
  );
}
