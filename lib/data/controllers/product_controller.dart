import 'package:crud_product_app/data/models/product.dart';
import 'package:crud_product_app/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;
  var currentPage = 1;
  var limit = 8;
  var hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.assignAll(await ProductRepository().getProducts(currentPage, limit)); // Fetch products from repository
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct(ProductCreate product) async {
    try {
      isLoading.value = true;
      await ProductRepository().addProduct(product);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String id_product) async {
    try {
      isLoading.value = true;
      await ProductRepository().deleteProduct(id_product);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(ProductEdit product) async {
    try {
      isLoading.value = true;
      await ProductRepository().updateProduct(product);
    } finally {
      isLoading.value = false;
    }
  }

  void updateProductInList(Product updatedProduct) {
    final index = products.indexWhere((product) => product.id_product == updatedProduct.id_product);
    if (index != -1) {
      products[index] = updatedProduct;
      update();
    }
  }

  void nextPage() {
    if (hasMore) {
      currentPage++;
      fetchProducts();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      fetchProducts();
    }
  }
}