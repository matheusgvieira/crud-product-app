import 'package:crud_product_app/data/controllers/auth_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  final String baseUrl = 'http://localhost:8000';
  final storage = new FlutterSecureStorage();

  Future<List<Product>> getProducts() async {
    final String token = await AuthController().getToken();

    if (token.isEmpty) {
      throw Exception('Token not found');
    }

    final response = await http.get(Uri.parse('$baseUrl/products/'), headers: {
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Product> products = jsonData['items'].map<Product>((item) {
        return Product.fromJson(item);
      }).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}