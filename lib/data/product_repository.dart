import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// Reads the product list from the local JSON file (simulates an API response).
class ProductRepository {
  ProductRepository._();

  static const String _assetPath = 'assets/data/products.json';

  static Future<List<Product>> loadProducts() async {
    final String raw = await rootBundle.loadString(_assetPath);
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;

    return decoded
        .map((dynamic item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
