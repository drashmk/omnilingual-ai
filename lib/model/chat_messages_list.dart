import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessagesList extends ChangeNotifier {
  final List<types.Message> _items = [];

  List<types.Message> get items => _items;

  void insert(int index, types.Message value) {
    _items.insert(index, value);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void remove(types.Message value) {
    _items.remove(value);
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
