import 'package:crud_product_app/data/models/product.dart';
import 'package:crud_product_app/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.assignAll(await ProductRepository().getProducts()); // Fetch products from repository
    } finally {
      isLoading.value = false;
    }
  }
}