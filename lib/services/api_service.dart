import 'package:http/http.dart' as http;
import 'package:posts/models/apipost.dart';
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<Apipost>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts'));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Apipost.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des posts');
      }
    } catch (e) {
      print('Erreur API: $e');
      throw e;
    }
  }
}