import 'package:crud_product_app/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await AuthRepository().login(email, password);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await AuthRepository().logout();
    } finally {
      isLoading.value = false;
    }
  }
}