import 'package:flutter/material.dart';
import '../utils/form_storage.dart';
import 'messages_view.dart';

///Enregistrement local des messages
class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _formKey = GlobalKey<FormState>(); //Clé pour identifier le formulaire et le valider
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  //Valide le formulaire, enregistre les données et affiche un dialog de confirmation
  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      final contactData = {
        'nom': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
      };

      FormStorage.addMessage(contactData); // Stockage local (via shared_preferences ou autre)

      _formKey.currentState!.reset(); // Réinitialise le formulaire

      // Affiche une boîte de dialogue de confirmation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Message enregistré'),
          content: const Text('Voulez-vous voir la liste des messages enregistrés ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Ferme la boîte
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme d'abord le dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagesView()),
                ); // Navigue vers la liste des messages
              },
              child: const Text('Oui'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nom'),
              TextFormField(
                controller: _nameController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Veuillez entrer votre nom' : null,
              ),
              const SizedBox(height: 10),

              const Text('Email'),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
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
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Veuillez entrer votre message' : null,
              ),
              const SizedBox(height: 20),

              // Bouton d'envoi centré
              Center(
                child: ElevatedButton(
                  onPressed: _sendMessage,
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
