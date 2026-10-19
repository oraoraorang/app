import '../models/product.dart';

/// Unique category names, in the order they first appear in the list.
List<String> categoriesOf(List<Product> products) {
  final List<String> result = <String>[];
  for (final Product product in products) {
    if (!result.contains(product.category)) {
      result.add(product.category);
    }
  }
  return result;
}

String formatPrice(double value) => '\$${value.toStringAsFixed(2)}';
