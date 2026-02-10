import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterService {
  static const String _baseUrl = 'http://api.test/';
  static Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}register.php'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        print('Inscription réussie');
      } else {
        throw Exception('Échec de l\'inscription : ${data['message']}');
      }
    }
  }
}
