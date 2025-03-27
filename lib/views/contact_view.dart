import 'package:flutter/material.dart';

// Définition du widget Stateful pour la page de contact
class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

// État associé au widget ContactView
class _ContactViewState extends State<ContactView> {
  // Clé globale pour identifier le formulaire et faciliter sa validation
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour récupérer le texte saisi dans les champs de texte
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Fonction appelée lors de l'appui sur le bouton "Envoyer"
  void _sendMessage() {
    // Vérifie si le formulaire est valide
    if (_formKey.currentState!.validate()) {
      // Si valide, affiche une SnackBar de confirmation avec le nom de l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message envoyé par ${_nameController.text} !')),
      );

      // Réinitialise les champs du formulaire après l'envoi
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar affichant le titre de la page
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      // Corps de la page avec un padding pour l'esthétique
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Formulaire contenant les champs de saisie et le bouton d'envoi
        child: Form(
          key: _formKey, // Association de la clé au formulaire pour la validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nom'),
              // Champ de saisie pour le nom
              TextFormField(
                controller: _nameController, // Associe le contrôleur au champ
                validator: (value) {
                  // Validation : vérifie si le champ n'est pas vide
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10), // Espacement entre les champs
              const Text('Email'),
              // Champ de saisie pour l'email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Clavier adapté pour l'email
                validator: (value) {
                  // Validation : vérifie si le champ n'est pas vide et si l'email est valide
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text('Message'),
              // Champ de saisie pour le message
              TextFormField(
                controller: _messageController,
                maxLines: 4, // Permet d'avoir plusieurs lignes pour le message
                validator: (value) {
                  // Validation : vérifie si le champ n'est pas vide
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Bouton centré pour envoyer le formulaire
              Center(
                child: ElevatedButton(
                  onPressed: _sendMessage, // Appelle la fonction _sendMessage lors de l'appui
                  child: const Text('Envoyer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
