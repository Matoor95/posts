class Produit {
  final int id;
  final String libelle;
  final double prix;
  final String description;

  Produit({
    required this.id,
    required this.libelle,
    required this.prix,
    required this.description,
  });
// La fonction fromJson est une méthode de désérialisation qui permet de convertir 
//des données JSON brutes (reçues d'une API) en un objet Dart de type Produit
 factory Produit.fromJson(Map<String, dynamic> json) {
  return Produit(
    id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
    libelle: json['libelle'].toString(),
    prix: double.parse(json['prix'].toString()),
    description: json['description']?.toString() ?? '',
  );
}
}
