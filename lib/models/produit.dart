class Produit {
  final int id;
  final String libelle;
  final double prix;
  final int qte;

  Produit({
    required this.id,
    required this.libelle,
    required this.prix,
    required this.qte,
  });
// La fonction fromJson est une méthode de désérialisation qui permet de convertir 
//des données JSON brutes (reçues d'une API) en un objet Dart de type Produit
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      libelle: json['libelle'],
      prix: json['prix'].toDouble(),
      qte: json['qte'],
    );
  }
}
