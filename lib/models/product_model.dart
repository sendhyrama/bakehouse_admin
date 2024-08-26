class Product {
  final String imageUrl;
  final String productName;
  final String userId;
  final double price;
  final String productUnit;

  Product({
    required this.imageUrl,
    required this.productName,
    required this.userId,
    required this.price,
    required this.productUnit,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      imageUrl: data['imageUrl'] ?? '',
      productName: data['name'] ?? '',
      userId: data['userId'] ?? '',
      price: data['price'] ?? 0.0,
      productUnit: data['unit'] ?? '',
    );
  }
}
