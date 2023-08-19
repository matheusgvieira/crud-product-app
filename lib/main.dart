import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/presentation/screens/login_screen.dart';
import 'package:crud_product_app/presentation/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

void main() async {
  final storage = new FlutterSecureStorage();
  final String token = storage.read(key: '@products/jwt_token').toString() ?? '';


  runApp(GetMaterialApp(
    initialRoute: token.isNotEmpty ? '/productList' : '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginScreen()),
      GetPage(name: '/productList', page: () => ProductListScreen())
    ],
    initialBinding: ProductControllerBinding(), // Bind controllers
  ));
}

class ProductControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    // Add bindings for other controllers as needed
  }
}
