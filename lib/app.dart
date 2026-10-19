import 'package:flutter/material.dart';

import 'models/cart_item.dart';
import 'models/product.dart';
import 'routes.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_screen.dart';
import 'state/cart_scope.dart';

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key, required this.products, this.loadError});

  final List<Product> products;
  final String? loadError;

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  // The cart lives here and is updated with setState.
  final List<CartItem> _cart = <CartItem>[];

  void _addToCart(Product product) {
    setState(() {
      final int index =
          _cart.indexWhere((CartItem item) => item.product.id == product.id);
      if (index == -1) {
        _cart.add(CartItem(product: product, quantity: 1));
      } else {
        _cart[index] =
            CartItem(product: product, quantity: _cart[index].quantity + 1);
      }
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      final int index =
          _cart.indexWhere((CartItem item) => item.product.id == product.id);
      if (index == -1) {
        return;
      }
      final int current = _cart[index].quantity;
      if (current <= 1) {
        _cart.removeAt(index);
      } else {
        _cart[index] = CartItem(product: product, quantity: current - 1);
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cart.removeWhere((CartItem item) => item.product.id == product.id);
    });
  }

  void _clearCart() {
    setState(() {
      _cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

    // If the JSON file could not be read, show the problem instead of an empty app.
    if (widget.loadError != null) {
      return MaterialApp(
        title: 'Mini Catalog',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Scaffold(
          appBar: AppBar(title: const Text('Mini Catalog')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Could not load products:\n${widget.loadError}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    return CartScope(
      items: List<CartItem>.unmodifiable(_cart),
      onAdd: _addToCart,
      onDecrease: _decreaseQuantity,
      onRemove: _removeFromCart,
      onClear: _clearCart,
      child: MaterialApp(
        title: 'Mini Catalog',
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: AppRoutes.home,
        routes: <String, WidgetBuilder>{
          AppRoutes.home: (BuildContext context) =>
              HomeScreen(products: widget.products),
          AppRoutes.products: (BuildContext context) =>
              ProductsScreen(products: widget.products),
          AppRoutes.productDetail: (BuildContext context) =>
              const ProductDetailScreen(),
          AppRoutes.cart: (BuildContext context) => const CartScreen(),
        },
      ),
    );
  }
}
