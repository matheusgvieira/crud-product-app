class Product {
  final String id_product;
  final String name;
  final double price;
  final String created_at;

  Product({required this.id_product, required this.name, required this.price, required this.created_at});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id_product: json['id_product'],
      name: json['name'],
      price: json['price'],
      created_at: json['created_at'],
    );
  }
}

class ProductCreate {
  final String name;
  final double price;

  ProductCreate({required this.name, required this.price});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}

class ProductEdit {
  final String id_product;
  final String name;
  final double price;

  ProductEdit({required this.name, required this.price, required this.id_product});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}


