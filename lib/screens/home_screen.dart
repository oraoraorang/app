import 'package:flutter/material.dart';

import '../models/product.dart';
import '../routes.dart';
import '../utils/product_utils.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/category_card.dart';
import '../widgets/product_image.dart';

/// Home: banner, category shortcuts and a button to browse every product.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = categoriesOf(products);
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Catalog'),
        actions: const <Widget>[CartBadgeButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 3,
              child: ProductImage(
                path: 'assets/images/banner.png',
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Categories', style: text.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories.map((String category) {
              final int count = products
                  .where((Product product) => product.category == category)
                  .length;
              return CategoryCard(
                name: category,
                itemCount: count,
                onTap: () {
                  // The category name is sent to the next page as a route argument.
                  Navigator.pushNamed(
                    context,
                    AppRoutes.products,
                    arguments: category,
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.products),
            icon: const Icon(Icons.grid_view),
            label: const Text('Browse all products'),
          ),
        ],
      ),
    );
  }
}
