import 'package:flutter/material.dart';

IconData categoryIcon(String category) {
  switch (category) {
    case 'Electronics':
      return Icons.devices;
    case 'Clothing':
      return Icons.checkroom;
    case 'Books':
      return Icons.menu_book;
    case 'Beauty':
      return Icons.spa;
    case 'Home':
      return Icons.chair;
    default:
      return Icons.category;
  }
}

/// Round icon + name + item count. Tapping opens the product grid for that category.
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.itemCount,
    required this.onTap,
  });

  final String name;
  final int itemCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;

    return SizedBox(
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 28,
                backgroundColor: colors.primaryContainer,
                child: Icon(categoryIcon(name), color: colors.onPrimaryContainer),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                textAlign: TextAlign.center,
                style: text.labelLarge,
              ),
              Text(
                '$itemCount items',
                style: text.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
