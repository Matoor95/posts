import 'package:posts/models/apipost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  static Future<List<Apipost>> fetchApiposts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
