//Représente un article récupéré depuis l’API

class Article {
  final int userId; 
  final int id;     
  final String title; 
  final String body;  

  //Constructeur de la classe Article
  Article({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  //Méthode factory : permet de créer un objet Article à partir d’un JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      userId: json['userId'], 
      id: json['id'],         
      title: json['title'],   
      body: json['body'],     
    );
  }
}
