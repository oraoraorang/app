import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_scope.dart';
import '../utils/product_utils.dart';
import '../widgets/add_to_cart.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/product_image.dart';

/// Detail page. The Product arrives as a route argument.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is! Product) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: const Center(child: Text('Product not found')),
      );
    }

    final Product product = arguments;
    final int inCart = CartScope.of(context).quantityOf(product);
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const <Widget>[CartBadgeButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: ProductImage(
                path: product.image,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Chip(label: Text(product.category)),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(product.rating.toStringAsFixed(1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(product.name, style: text.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    formatPrice(product.price),
                    style: text.headlineMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Description', style: text.titleMedium),
                  const SizedBox(height: 4),
                  Text(product.description, style: text.bodyLarge),
                  if (inCart > 0) ...<Widget>[
                    const SizedBox(height: 16),
                    Text(
                      'In your cart: $inCart',
                      style: text.titleSmall?.copyWith(color: colors.primary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () => addToCartWithFeedback(context, product),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to cart'),
          ),
        ),
      ),
    );
  }
}
