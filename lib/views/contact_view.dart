import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart';
import 'messages_view.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _formKey = GlobalKey<FormState>();
  final ContactController _controller = ContactController();

  String _nom = '';
  String _email = '';
  String _message = '';

  void _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final contactData = {
        'nom': _nom,
        'email': _email,
        'message': _message,
      };

      await _controller.saveMessage(contactData);
      _formKey.currentState!.reset();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Message enregistré"),
          content: const Text("Voulez-vous voir vos messages ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Non"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MessagesView()),
                );
              },
              child: const Text("Oui"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer votre nom' : null,
                onSaved: (value) => _nom = value ?? '',
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Veuillez entrer votre email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Email invalide';
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer votre message' : null,
                onSaved: (value) => _message = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _sendMessage, child: const Text("Envoyer")),
            ],
          ),
        ),
      ),
    );
  }
} 
