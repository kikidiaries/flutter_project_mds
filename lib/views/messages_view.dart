import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart'; //Contrôleur pour accéder aux messages sauvegardés

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final ContactController _controller = ContactController(); //Instance du contrôleur
  late Future<List<String>> _messagesFuture; //Stocke la future liste de messages à charger

  @override
  void initState() {
    super.initState();
    _messagesFuture = _controller.getMessages(); //Récupère les messages au démarrage de la page
  }

  void _refreshMessages() {
    setState(() {
      _messagesFuture = _controller.getMessages(); //Recharge les messages (utile après suppression)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages enregistrés'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete), //Bouton de suppression
            tooltip: "Tout effacer",
            onPressed: () async {
              await _controller.clearMessages(); //Supprime les messages
              _refreshMessages(); //Recharge l'écran après suppression
            },
          )
        ],
      ),
      body: FutureBuilder<List<String>>( //Permet de construire l’interface à partir d’une Future
        future: _messagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); //Attente : on montre un loader
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}')); //Erreur de chargement
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final messages = snapshot.data!;
            return ListView.builder( //Affiche les messages dans une liste
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(messages[index]), //Affiche chaque message
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Aucun message enregistré.')); //Aucun message trouvé
          }
        },
      ),
    );
  }
}
