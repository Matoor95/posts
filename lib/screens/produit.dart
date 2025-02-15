// lib/pages/produit_page.dart
import 'package:flutter/material.dart';
import 'package:posts/services/produit_service.dart';
import '../models/produit.dart';

class ProduitPage extends StatefulWidget {
  const ProduitPage({Key? key}) : super(key: key);

  @override
  _ProduitPageState createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  late Future<List<Produit>> _futureProduits;

  @override
  void initState() {
    super.initState();
    _futureProduits = ProduitService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue Produits'),
        centerTitle: true,
      ),
      body: _buildProductList(),
    );
  }

  Widget _buildProductList() {
    return FutureBuilder<List<Produit>>(
      future: _futureProduits,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        }
        
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyListWidget();
        }
        
        return _buildProductGridView(snapshot.data!);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Erreur de chargement:\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() { _futureProduits = ProduitService.fetchProducts(); }),
            child: const Text('Réessayer'),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyListWidget() {
    return const Center(
      child: Text(
        'Aucun produit disponible',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildProductGridView(List<Produit> produits) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: produits.length,
      itemBuilder: (context, index) {
        final produit = produits[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_bag,
                      size: 60,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  produit.libelle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${produit.prix.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stock: ${produit.qte}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}