import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/product_utils.dart';
import 'product_image.dart';

/// Card used in the product grid.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ProductImage(
                path: product.image,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 4, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall,
                  ),
                  Text(
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodySmall,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          formatPrice(product.price),
                          style: text.titleMedium,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Add to cart',
                        onPressed: onAddToCart,
                        icon: const Icon(Icons.add_shopping_cart),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
