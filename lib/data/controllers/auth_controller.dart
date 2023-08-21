import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> login(String token) async {
    await secureStorage.write(key: '@products/jwt_token', value: token);
  }

  Future<void> logout() async {
    await secureStorage.delete(key: '@products/jwt_token');
  }

  Future<String> getToken() async {
    final token = await secureStorage.read(key: '@products/jwt_token') ?? '';
    return token;
  }

  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: '@products/jwt_token');

    if (token == null) {
      return false;
    }
    return true;
  }
}