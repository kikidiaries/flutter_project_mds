import 'package:shared_preferences/shared_preferences.dart'; //stocker les données localement
class ContactController {
  static const String _key = 'messages'; //stocker + récupérer les messages dans SharedPreferences

  Future<void> saveMessage(Map<String, String> message) async {
    final prefs = await SharedPreferences.getInstance(); //récupère l'accès à sharedpreferences
    final existing = prefs.getStringList(_key) ?? []; 

    // On formate le message avec les infos du formulaire + la date actuelle
    final formatted = '''
Nom: ${message['nom']}
Email: ${message['email']}
Message: ${message['message']}
Date: ${DateTime.now().toIso8601String()}
''';

    existing.insert(0, formatted); //ajouter le nouveau message au début de la liste
    await prefs.setStringList(_key, existing); 
  }

  //ire tous les messages sauvegardés
  Future<List<String>> getMessages() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? []; 
  }

  // Méthode pour supprimer tous les messages
  Future<void> clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key); //Supprime les messages sauvegardés
  }
}
