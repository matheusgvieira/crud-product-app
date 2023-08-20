import 'package:crud_product_app/data/controllers/auth_controller.dart';
import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/presentation/screens/login_screen.dart';
import 'package:crud_product_app/presentation/screens/product_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool isLoggedIn = await AuthController().isLoggedIn();

  runApp(GetMaterialApp(
    initialRoute: isLoggedIn ? '/productList' : '/login',
    title: 'CRUD Product App',
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
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<AuthController>(() => AuthController());
    // Add bindings for other controllers as needed
  }
}
