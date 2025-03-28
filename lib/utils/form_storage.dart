



class FormStorage {
  static final List<Map<String, String>> _messages = [];

  static void addMessage(Map<String, String> message) {
    _messages.add(message);
  }

  static List<Map<String, String>> get messages => _messages;
}
