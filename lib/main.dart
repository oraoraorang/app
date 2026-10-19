import 'package:flutter/material.dart';

import 'app.dart';
import 'data/product_repository.dart';
import 'models/product.dart';

Future<void> main() async {
  // Needed because we read an asset file before runApp().
  WidgetsFlutterBinding.ensureInitialized();

  List<Product> products = <Product>[];
  String? loadError;

  try {
    products = await ProductRepository.loadProducts();
  } catch (e) {
    loadError = e.toString();
  }

  runApp(MiniKatalogApp(products: products, loadError: loadError));
}
