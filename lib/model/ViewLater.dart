import 'package:flutter/material.dart';
import 'Document.dart';
import '../model/Document.dart';

class ViewLaterModel extends ChangeNotifier {
  late Documents _documents;

  Documents get documents => _documents;

  set documents(Documents newCatalog) {
    _documents = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  List<Documents> recentsdoc = [];
  List<Documents> docs = [];

  void add(Documents item) {
    if (docs.contains(item)) {
    } else {
      docs.add(item);
    }
  }

  void addRecent(List<Documents> item) {
    recentsdoc.addAll(item);
  }

  void removeAll() {
    docs.clear();
    notifyListeners();
  }

  void romoveFromList(Documents item) {
    docs.remove(item);
    notifyListeners();
  }
}
