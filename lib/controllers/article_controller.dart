import 'dart:convert'; //convertir les données JSON
import 'package:http/http.dart' as http;
import '../models/article.dart'; 

class ArticleController {
Future<List<Article>> fetchArticles({int page = 1, int limit = 10}) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception('Échec du chargement des articles');
  }
}

}


