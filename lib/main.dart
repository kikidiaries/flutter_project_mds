import 'package:flutter/material.dart';

//On importe les vues (pages de l'application)
import 'views/apropos_view.dart';
import 'views/contact_view.dart';
import 'views/articles_view.dart';

//Utilisation de ValueNotifier pour gérer le changement de thème (clair/sombre)
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// Fonction qui démarre l’application
void main() {
  runApp(const MyApp()); // runApp lance le widget principal
}

//Le widget principal de l’application (stateless = il ne change pas d’état)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier, //On écoute les changements de thème
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, //Cache le banner de debug
          title: 'Projet Flutter', //Titre global de l'application
          theme: ThemeData.light(), //Thème clair par défaut
          darkTheme: ThemeData.dark(), //Thème sombre
          themeMode: currentMode, // Applique le thème actuel (clair ou sombre)
          initialRoute: '/', // Définir la route de départ (ici la page d'accueil)
          routes: {
            '/': (context) => const HomePage(), // Route pour la page d'accueil
            '/apropos': (context) => const AproposView(), // Page "À propos"
            '/contact': (context) => const ContactView(), // Page de contact
            '/articles': (context) => const ArticlesView(), // Page des articles
          },
        );
      },
    );
  }
}

// Ce widget représente la page d’accueil (page principale)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold = structure de base d'une page (AppBar, Drawer, Body, etc.)
      appBar: AppBar(
        title: const Text('Accueil'), // Titre affiché en haut de la page
      ),
      drawer: Drawer(
        // Le Drawer, c’est le menu qui se glisse à gauche quand on clique sur le bouton "hamburger"
        child: ListView(
          padding: EdgeInsets.zero, // On enlève le padding par défaut
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue), // Fond bleu
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24), // Titre blanc, taille 24
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info), // Petite icône à gauche
              title: const Text('À Propos'), // Texte du bouton
              onTap: () {
                // Quand on clique, on change de page vers /apropos
                Navigator.pushNamed(context, '/apropos');
              },
            ),

            ListTile(
              leading: const Icon(Icons.contact_mail), // Icône de contact
              title: const Text('Contact'), // Texte du bouton
              onTap: () {
                Navigator.pop(context); // Ferme le Drawer
                Navigator.pushNamed(context, '/contact'); // Va sur la page Contact
              },
            ),

            ListTile(
              leading: const Icon(Icons.article), // Icône d'articles
              title: const Text('Articles'), // Texte du bouton
              onTap: () {
                Navigator.pushNamed(context, '/articles'); // Va sur la page Articles
              },
            ),

            ListTile(
              leading: const Icon(Icons.brightness_6), //Icône pour changer le thème
              title: const Text('Changer le thème'), //exte du bouton
              onTap: () {
                //Change le thème actuel entre clair et sombre
                themeNotifier.value = themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
                Navigator.pop(context); // Ferme le Drawer après le clic
              },
            ),

          ],
        ),
      ),
      body: const Center(
        // Corps de la page (au centre)
        child: Text(
          'Bienvenue sur la page d\'accueil !',
          style: TextStyle(fontSize: 20), // Texte de bienvenue
        ),
      ),
    );
  }
}
