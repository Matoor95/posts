import 'package:flutter/material.dart';
import 'package:posts/models/apipost.dart';
import 'package:posts/screens/produit.dart';
import 'package:posts/services/api_service.dart';

class ApiPostScreen extends StatefulWidget { // Renommage pour éviter le conflit de noms
  const ApiPostScreen({ Key? key }) : super(key: key);

  @override
  _ApiPostScreenState createState() => _ApiPostScreenState();
}

class _ApiPostScreenState extends State<ApiPostScreen> {
  late Future<List<Apipost>> futurePosts; // Utilisation du bon nom de classe (Apipost)

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Apipost>>( // Correction du type générique
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } 
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun post trouvé'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Apipost post = snapshot.data![index]; // Correction du nom de classe
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                leading: CircleAvatar(child: Text(post.id.toString())),
              );
            },
          );
        },
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProduitPage()),
);
      },
      child: const Icon(Icons.production_quantity_limits),
    )
    );
  }
}