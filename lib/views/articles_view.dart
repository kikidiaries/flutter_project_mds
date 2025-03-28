import 'package:flutter/material.dart';
import '../models/article.dart';
import '../controllers/article_controller.dart';
import 'article_detail_view.dart';

class ArticlesView extends StatefulWidget {
  const ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  final ArticleController _controller = ArticleController(); //gère la récupération API
  List<Article> _articles = []; //liste des articles affichés
  int _currentPage = 1; //page actuelle
  final int _limit = 10; //articles par page
  bool _isLoading = false; //indique un chargement en cours
  bool _hasMore = true; //true s’il y a encore des articles

  @override
  void initState() {
    super.initState();
    _fetchArticles(); //chargement initial
  }

  Future<void> _fetchArticles() async {
    setState(() => _isLoading = true); //active le loader
    try {
      final newArticles = await _controller.fetchArticles(
        page: _currentPage,
        limit: _limit,
      );
      setState(() {
        _articles = newArticles;
        _hasMore = newArticles.length == _limit; //s’il y a potentiellement plus
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur de chargement : $e")), //affiche l’erreur
      );
    }
  }

  void _goToNextPage() {
    if (_hasMore) {
      setState(() => _currentPage++);
      _fetchArticles(); //page suivante
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() => _currentPage--);
      _fetchArticles(); //page précédente
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')), //titre de la page
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) //loader
          : Column(
              children: [
                Expanded(
                  child: _articles.isEmpty
                      ? const Center(child: Text('Aucun article disponible.')) //si vide
                      : ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return ListTile(
                              title: Text(article.title), //titre
                              subtitle: Text(article.body.length > 50
                                  ? '${article.body.substring(0, 50)}...'
                                  : article.body), //aperçu du contenu
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ArticleDetailView(
                                      article: article,
                                    ),
                                  ),
                                ); //détail de l’article
                              },
                            );
                          },
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _currentPage > 1 ? _goToPreviousPage : null,
                      child: const Text("← Précédent"), //bouton retour
                    ),
                    Text("Page $_currentPage"), //page affichée
                    TextButton(
                      onPressed: _hasMore ? _goToNextPage : null,
                      child: const Text("Suivant →"), //bouton suivant
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
