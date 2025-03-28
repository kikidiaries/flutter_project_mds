import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleDetailView extends StatelessWidget {
  final Article article; //article à afficher

  const ArticleDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détail de l\'article')), //titre dynamique
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //alignement à gauche
          children: [
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ), //titre en gras
            const SizedBox(height: 12),
            Text(
              'Article #${article.id} par User ${article.userId}',
              style: const TextStyle(color: Colors.grey),
            ), //métadonnées
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  article.body,
                  style: const TextStyle(fontSize: 18),
                ), //contenu complet
              ),
            ),
          ],
        ),
      ),
    );
  }
}
