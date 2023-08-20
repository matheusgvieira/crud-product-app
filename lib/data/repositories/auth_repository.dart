import 'package:crud_product_app/data/models/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String baseUrl = 'http://127.0.0.1:8000';
  final headers = {'Content-Type': 'application/json'};

  Future<String> login(String email, String password) async {

    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: json.encode(
          {
            'email': email,
            'password': password,
          }
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      Auth auth = Auth.fromJson(jsonData);

      String token = auth.token_type + ' ' + auth.access_token;

      return token;
    } else {
      throw Exception('Failed to login');
    }
  }
}
