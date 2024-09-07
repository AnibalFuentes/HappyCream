class Product {
  String id;
  String name;
  String description;
  String image;
  double price;
  bool state;
  String categoryId; // Añade este campo

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.state,
    required this.categoryId,
    required this.price, // Añade este campo
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      state: map['state'] ?? true,
      price: map['price'] ?? 0.0, // Añade este campo
      categoryId: map['categoryId'] ?? '', // Añade este campo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'state': state,
      'price': price, // Añade este campo
      'categoryId': categoryId, // Añade este campo
    };
  }
}
