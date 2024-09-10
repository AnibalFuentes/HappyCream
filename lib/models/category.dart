class Category {
  String id;
  String name;
  String? description;
  int tProduct;
  bool state;

  Category({required this.id, required this.name, required this.state,required this.tProduct, this.description});

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      tProduct: map['tProduct'] ?? 0,
      state: map['state'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'tProduct': tProduct,
      'state': state,
    };
  }
}
