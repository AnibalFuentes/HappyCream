class Category {
  String id;
  String name;
  int tProduct;
  bool state;

  Category({required this.id, required this.name, required this.state,required this.tProduct});

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      tProduct: map['tProduct'] ?? 0,
      state: map['state'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tProduct': tProduct,
      'state': state,
    };
  }
}
