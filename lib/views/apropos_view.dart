import 'package:flutter/material.dart';

///Contenu statique, non interactif.
class AproposView extends StatelessWidget {
  const AproposView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À Propos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          //blocs de texte + image
          children: [
            //Titre mis en avant pour la lisibilité
            const Text(
              'Le Golden Retriever : Un compagnon exceptionnel\n',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Originaire d\'Écosse, le Golden Retriever est une race de chien reconnue pour sa douceur, son intelligence et sa loyauté. '
              'Développée au XIXe siècle par Lord Tweedmouth, cette race était initialement destinée à la chasse, notamment pour rapporter le gibier d\'eau '
              'grâce à son excellent flair et son amour pour l\'eau.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text(
              'Caractéristiques principales :\n'
              '- Taille : 51 à 61 cm au garrot\n'
              '- Poids : 25 à 34 kg\n'
              '- Espérance de vie : 10 à 12 ans\n'
              '- Robe : Couleur variant du crème au doré foncé\n'
              '- Tempérament : Sociable, affectueux, intelligent et fiable',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text(
              'Le Golden Retriever est également très polyvalent et excelle dans diverses activités telles que l\'agilité, le sauvetage, '
              'le dressage et les concours de beauté. C\'est un chien de famille par excellence, réputé pour son caractère jovial, doux et accommodant, '
              'ce qui en fait un compagnon idéal pour les enfants de tout âge.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20), //créer un espace (vertical ou horizontal) entre deux widgets

            Center(
              child: Image.asset(
                'assets/images/Picture.png',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
