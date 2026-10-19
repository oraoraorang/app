/// A product of the catalog. Matches one object of assets/data/products.json.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
  });

  final int id;
  final String name;
  final String category;
  final double price;
  final String description;

  /// Asset path, e.g. assets/images/products/p01.png
  final String image;
  final double rating;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'image': image,
      'rating': rating,
    };
  }
}
