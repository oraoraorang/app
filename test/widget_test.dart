import 'package:flutter_test/flutter_test.dart';

// The package name must match the "name:" line in pubspec.yaml (mini_katalog).
import 'package:mini_katalog/app.dart';
import 'package:mini_katalog/models/product.dart';

void main() {
  const List<Product> products = <Product>[
    Product(
      id: 1,
      name: 'Test Phone',
      category: 'Electronics',
      price: 10,
      description: 'A test product',
      image: 'assets/images/products/p01.png',
      rating: 4.5,
    ),
  ];

  testWidgets('home screen shows the title and categories', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp(products: products));
    await tester.pumpAndSettle();

    expect(find.text('Mini Catalog'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Electronics'), findsOneWidget);
  });
}
