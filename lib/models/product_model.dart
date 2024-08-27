class Product {
  final String id;
  final String description;
  final String imageUrl;
  final String name;
  final double price;
  final String unit;
  final String userId;

  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.unit,
    required this.userId,
  });

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      description: data['description'],
      imageUrl: data['imageUrl'],
      name: data['name'],
      price: (data['price'] as num).toDouble(),
      unit: data['unit'],
      userId: data['userId'],
    );
  }
}
