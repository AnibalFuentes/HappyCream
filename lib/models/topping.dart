class Topping {
  String id;
  String name;

  String image;
  double price;
  bool state;
  // Añade este campo

  Topping({
    required this.id,
    required this.name,
    required this.image,
    required this.state,
    required this.price, // Añade este campo
  });

  factory Topping.fromMap(Map<String, dynamic> map, String id) {
    return Topping(
      id: id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      state: map['state'] ?? true,
      price: map['price'] ?? 0.0, 
      // Añade este campo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,

      'image': image,
      'state': state,
      'price': price, // Añade este campo
    };
  }
}
