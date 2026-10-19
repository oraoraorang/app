import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../state/cart_scope.dart';
import '../utils/product_utils.dart';
import '../widgets/product_image.dart';

/// Simple cart: change quantities, remove items, see the total.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartScope cart = CartScope.of(context);
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: <Widget>[
          if (cart.items.isNotEmpty)
            TextButton(onPressed: cart.onClear, child: const Text('Clear')),
        ],
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.shopping_cart_outlined, size: 64),
                  const SizedBox(height: 12),
                  Text('Your cart is empty', style: text.titleMedium),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to shopping'),
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _CartRow(item: cart.items[index], cart: cart);
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Total', style: text.titleLarge),
                            Text(
                              formatPrice(cart.totalPrice),
                              style: text.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => _checkout(context, cart),
                            child: const Text('Checkout (demo)'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _checkout(BuildContext context, CartScope cart) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Order placed (demo)'),
          content: const Text(
            'This is a simulation. No real order was created.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                cart.onClear();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.item, required this.cart});

  final CartItem item;
  final CartScope cart;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ProductImage(
                path: item.product.image,
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall,
                  ),
                  Text(
                    '${formatPrice(item.product.price)} each',
                    style: text.bodySmall,
                  ),
                  Text(
                    formatPrice(item.subtotal),
                    style: text.titleMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Decrease',
              onPressed: () => cart.onDecrease(item.product),
              icon: const Icon(Icons.remove_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
            Text('${item.quantity}', style: text.titleMedium),
            IconButton(
              tooltip: 'Increase',
              onPressed: () => cart.onAdd(item.product),
              icon: const Icon(Icons.add_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              tooltip: 'Remove',
              onPressed: () => cart.onRemove(item.product),
              icon: const Icon(Icons.delete_outline),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
