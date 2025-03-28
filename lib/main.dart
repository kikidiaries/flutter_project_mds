import 'package:flutter/material.dart';


//On importe les vues
import 'views/apropos_view.dart';
import 'views/contact_view.dart';
import 'views/articles_view.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// La fonction principale qui démarre l’application
void main() {
  runApp(const MyApp()); // runApp lance le widget principal de notre app
}

// Le widget principal de l’application (stateless = il ne change pas d’état)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Projet Flutter',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/apropos': (context) => const AproposView(),
            '/contact': (context) => const ContactView(),
            '/articles': (context) => const ArticlesView(),
          },
        );
      },
    );
  }
}

//Ce widget représente la page d’accueil (page principale)
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
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context); // Ferme le Drawer
                Navigator.pushNamed(context, '/contact'); // Va sur la page Contact
              },
            ),

            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Articles'),
              onTap: () {
                Navigator.pushNamed(context, '/articles');
              },
            ),

            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Changer le thème'),
              onTap: () {
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
