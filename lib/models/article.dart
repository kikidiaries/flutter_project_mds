//Ici on définit une classe pour représenter les articles récuperés depuis l'API 
// on pensera aussi à créer une vue pour afficher les titres des articles dans une ListView

class Article {
  final int userId;
  final int id;
  final String title;
  final String body;

  Article({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Méthode pour créer une instance d'Article à partir d'une map JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
