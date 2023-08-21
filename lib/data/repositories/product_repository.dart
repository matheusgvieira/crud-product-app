import 'package:crud_product_app/presentation/screens/login_screen.dart';
import 'package:crud_product_app/data/controllers/auth_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  final String baseUrl = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:8000');
  final storage = new FlutterSecureStorage();

  Future<List<Product>> getProducts(int page, int limit) async {
    final String token = await AuthController().getToken();

    if (token.isEmpty) {
      print('Token is empty');
      Get.snackbar('Error', 'Please login first');
      Get.off(() => LoginScreen());
    }

    final response = await http.get(Uri.parse('$baseUrl/products/?page=$page&limit=$limit'), headers: {
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Product> products = jsonData['items'].map<Product>((item) {
        return Product.fromJson(item);
      }).toList();
      return products;
    } else {

      final jsonData = json.decode(response.body);

      if (jsonData['detail'] == "Token has expired") {
        await AuthController().logout();
        Get.off(() => LoginScreen());
      }

      throw Exception(jsonData['detail']);
    }
  }

  Future<void> addProduct(ProductCreate product) async {
    final String token = await AuthController().getToken();

    if (token.isEmpty) {
      print('Token is empty');
      Get.snackbar('Error', 'Please login first');
      Get.off(() => LoginScreen());
    }

    final response = await http.post(Uri.parse('$baseUrl/products/'), headers: {
      'Authorization': token,
      'Content-Type': 'application/json',
    }, body: json.encode(product.toJson()));

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Product added successfully');
    } else {
      final jsonData = json.decode(response.body);

      if (jsonData['detail'] == "Token has expired") {
        await AuthController().logout();
        Get.off(() => LoginScreen());
      }

      throw Exception(jsonData['detail']);
    }
  }

  Future<void> updateProduct(ProductEdit product) async {
    final String token = await AuthController().getToken();

    if (token.isEmpty) {
      print('Token is empty');
      Get.snackbar('Error', 'Please login first');
      Get.off(() => LoginScreen());
    }

    final response = await http.put(Uri.parse('$baseUrl/products/${product.id_product}'), headers: {
      'Authorization': token,
      'Content-Type': 'application/json',
    }, body: json.encode(product.toJson()));

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Product updated successfully');
    } else {
      print(response);
      final jsonData = json.decode(response.body);

      print(jsonData);

      if (jsonData['detail'] == "Token has expired") {
        await AuthController().logout();
        Get.off(() => LoginScreen());
      }

      throw Exception(jsonData['detail']);
    }
  }

  Future<void> deleteProduct(String id_product) async {
    final String token = await AuthController().getToken();

    if (token.isEmpty) {
      print('Token is empty');
      Get.snackbar('Error', 'Please login first');
      Get.off(() => LoginScreen());
    }

    final response = await http.delete(Uri.parse('$baseUrl/products/$id_product'), headers: {
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Product deleted successfully');
    } else {
      final jsonData = json.decode(response.body);

      if (jsonData['detail'] == "Token has expired") {
        await AuthController().logout();
        Get.off(() => LoginScreen());
      }

      throw Exception(jsonData['detail']);
    }
  }
}