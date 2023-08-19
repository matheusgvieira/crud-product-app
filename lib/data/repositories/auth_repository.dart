import 'package:crud_product_app/data/models/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String baseUrl = 'http://localhost:8000';
  final storage = new FlutterSecureStorage();

  Future<Auth> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      Auth auth = Auth.fromJson(jsonData);

      // Save token to local storage
      String token = auth.token_type + ' ' + auth.access_token;
      // Save token to local storage
      await storage.write(key: '@products/jwt_token', value: token);

      return auth;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    await storage.delete(key: '@products/jwt_token');
  }
}
