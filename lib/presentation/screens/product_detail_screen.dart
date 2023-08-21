import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:crud_product_app/presentation/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  void removeProduct(Product product) {
    ProductController().deleteProduct(product.id_product);
  }

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final selectedProduct = productController.products.firstWhere((element) => element.id_product == product.id_product);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${selectedProduct.id_product}'),
            Text('Name: ${selectedProduct.name}'),
            Text('Price: ${selectedProduct.price}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductEditScreen(product: product),
                      ),
                    );
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    removeProduct(product);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}