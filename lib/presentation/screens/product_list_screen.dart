import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for state management

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.find(); // Get your controller instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              onTap: () {
                // Navigate to product details screen
                Get.toNamed('/productDetails', arguments: product);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to product form screen
          Get.toNamed('/productForm');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
