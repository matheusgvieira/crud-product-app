import 'package:crud_product_app/data/controllers/auth_controller.dart';
import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:crud_product_app/presentation/screens/product_add_screen.dart';
import 'package:crud_product_app/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListTableScreenState createState() => _ProductListTableScreenState();
}

class _ProductListTableScreenState extends State<ProductListScreen> {
  // final ProductController productController = Get.put(ProductController());

  final ProductController productController = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    productController.fetchProducts();
  }

  void navigateToProductDetail(Product product) {
    Get.to(ProductDetailScreen(product: product));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductAddScreen(),
                      ),
                    );
                  },
                  child: Text('Add Product'),
                ),
                ElevatedButton(
                  onPressed: () {
                    productController.fetchProducts(); // Reload products
                  },
                  child: Text('Search again'),
                ),
              ],
            ),

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
                    DataColumn(label: Text('')),
                  ],
                  rows: productController.products.map((Product product) {
                    return DataRow(cells: [

                      DataCell(Text(product.name)),
                      DataCell(Text(product.price.toString())),
                      DataCell(ElevatedButton(
                        onPressed: () {
                          navigateToProductDetail(product);
                        },
                        child: Icon(Icons.open_in_new),
                      ),),
                    ]);
                  }).toList(),
                ),
              );
            }),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    productController.previousPage(); // Fetch previous page
                  },
                  child: Text('Previous Page'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    productController.nextPage(); // Fetch next page
                  },
                  child: Text('Next Page'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


