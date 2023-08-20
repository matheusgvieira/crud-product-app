import 'package:crud_product_app/data/controllers/auth_controller.dart';
import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListTableScreenState createState() => _ProductListTableScreenState();
}

class _ProductListTableScreenState extends State<ProductListScreen> {
  // final ProductController productController = Get.put(ProductController());

  final ProductController productController = Get.find();

  @override
  void initState() {
    super.initState();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthController().logout();
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Edit')),
                  ],
                  rows: productController.products.map((Product product) {
                    return DataRow(cells: [

                      DataCell(Text(product.name)),
                      DataCell(Text(product.price.toString())),
                      DataCell(ElevatedButton(
                        onPressed: () {
                          // Handle edit button action
                          // For example: Navigate to edit screen
                        },
                        child: Text('Edit'),
                      ),),
                    ]);
                  }).toList(),
                ),
              );
            }),

            ElevatedButton(
              onPressed: () {
                productController.fetchProducts(); // Reload products
              },
              child: Text('Reload Products'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


