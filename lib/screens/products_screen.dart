import 'package:flutter/material.dart';

import '../models/product.dart';
import '../routes.dart';
import '../utils/product_utils.dart';
import '../widgets/add_to_cart.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/product_card.dart';

/// Product grid with a search field and category filter chips.
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.products});

  final List<Product> products;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _selectedCategory; // null means "All"
  bool _argumentsRead = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read the optional category argument once, when the page opens.
    if (!_argumentsRead) {
      _argumentsRead = true;
      final Object? arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is String) {
        _selectedCategory = arguments;
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    final String query = _query.trim().toLowerCase();
    return widget.products.where((Product product) {
      final bool matchesCategory =
          _selectedCategory == null || product.category == _selectedCategory;
      final bool matchesQuery =
          query.isEmpty || product.name.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = categoriesOf(widget.products);
    final List<Product> visibleProducts = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const <Widget>[CartBadgeButton()],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _searchController,
              onChanged: (String value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _query = '';
                          });
                        },
                      ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategory = null;
                      });
                    },
                  ),
                ),
                ...categories.map((String category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: visibleProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: visibleProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = visibleProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          // The whole Product object is sent as a route argument.
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: product,
                          );
                        },
                        onAddToCart: () =>
                            addToCartWithFeedback(context, product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
