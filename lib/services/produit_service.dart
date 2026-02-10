import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:posts/models/produit.dart';

class ProduitService {
  static const String _baseUrl = 'http://api.test/';

 static Future<List<Produit>> fetchProducts() async {
  final response = await http.get(Uri.parse('${_baseUrl}api.php'));

  if (response.statusCode == 200) {
    // Étape 1 : Décoder le JSON complet
    final Map<String, dynamic> data = json.decode(response.body);
    
    // Étape 2 : Vérifier la structure
    if (data['success'] == true && data['produits'] is List) {
      List<dynamic> produitsData = data['produits'];
      return produitsData.map((json) => Produit.fromJson(json)).toList();
    } else {
      throw Exception('Structure de données invalide');
    }
  } else {
    throw Exception('Échec du chargement : ${response.statusCode}');
  }
}
}