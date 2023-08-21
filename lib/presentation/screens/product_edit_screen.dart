import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;

  ProductEditScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<ProductEditScreen> {
  final ProductController productController = Get.put(ProductController());

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _idController = TextEditingController(text: widget.product.id_product);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void saveChanges() async {
    await ProductController().updateProduct(
      ProductEdit(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        id_product: _idController.text,
      ),
    );

    productController.updateProductInList(Product(
      id_product: _idController.text,
      name: _nameController.text,
      price: double.parse(_priceController.text),
      created_at: widget.product.created_at,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'Id'),
              enabled: false,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveChanges(); // Save changes and navigate back
                Navigator.pop(context, widget.product);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
