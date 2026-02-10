import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts/models/user.dart';

class AuthService {
  static const String _baseUrl = 'http://api.test/';
  static Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}login.php'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true && data['user'] != null) {
        return User.fromJson(data['user']);
      } else {
        throw Exception('Échec de la connexion : ${data['message']}');
      }
    } else {
      throw Exception('Échec de la connexion : ${response.statusCode}');
    }
  }
}
