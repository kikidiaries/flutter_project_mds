import 'package:flutter/material.dart';
import '../models/article.dart';  

//Le Widget reçoit un objet "Article" en paramètre et l'affiche 
class ArticleDetailView extends StatelessWidget {
  final Article article; //Article à afficher

  const ArticleDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Text(
          article.body,
        ),
      ),
    );
  }
}
