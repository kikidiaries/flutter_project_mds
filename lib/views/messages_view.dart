import 'package:flutter/material.dart';
import '../utils/form_storage.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = FormStorage.messages;

    return Scaffold(
      appBar: AppBar(title: const Text('Messages enregistrés')),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            title: Text(message['nom'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email : ${message['email'] ?? ''}'),
                Text('Message : ${message['message'] ?? ''}'),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
