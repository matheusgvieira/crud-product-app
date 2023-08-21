import 'package:crud_product_app/data/controllers/product_controller.dart';
import 'package:crud_product_app/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductAddScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<ProductAddScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void saveProduct() {
    ProductController().addProduct(
      ProductCreate(
        name: _nameController.text,
        price: double.parse(_priceController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                saveProduct(); // Save the new product and navigate back
                Navigator.pop(context);
              },
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
