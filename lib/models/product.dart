class Product {
  String id;
  String name;
  String description;
  String image;
  double price;
  bool state;
  bool topping;
  bool syrup;
  String categoryId;
  int cTopping;
  int cSyrup;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.state,
    required this.categoryId,
    required this.price, // Añade este campo
    required this.topping, // Añade este campo
    required this.syrup,
    required this.cTopping,
    required this.cSyrup,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      state: map['state'] ?? true,
      topping: map['topping'] ?? true,
      syrup: map['syrup'] ?? true,
      price: map['price'] ?? 0.0, // Añade este campo
      cTopping: map['cTopping'] ?? 0,
      cSyrup: map['cSyrup'] ?? 0,
      categoryId: map['categoryId'] ?? '', // Añade este campo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'state': state,
      'topping': topping,
      'syrup': syrup,
      'cTopping':cTopping,
      'cSyrup': cSyrup,
      'price': price, // Añade este campo
      'categoryId': categoryId, // Añade este campo
    };
  }
}
