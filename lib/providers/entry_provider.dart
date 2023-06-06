import 'package:flutter/material.dart';
import '../api/firebase_entry_api.dart';
import '../models/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EntryProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entriesStream;

  int? _entryCount;

  EntryProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntries();
  }
  
  Stream<QuerySnapshot> get entries => _entriesStream;
  int? get entryCount => _entryCount;

  fetchEntries() {
    _entriesStream = firebaseService.getAllEntries();
    notifyListeners();
  }
  
  void addEntry(Entry entry) async{
    String message = await firebaseService.addEntry(entry.toJson(entry));
    _entryCount = _entryCount! + 1;
    // ignore: avoid_print
    print(message);
    notifyListeners();
  }

  // edit entry in firebase
  void updateEditRequest(String id, bool toEdit) async {
    String message = await firebaseService.updateEditRequest(id, toEdit);
    print(message);
    notifyListeners();
  }

  void updateDeleteRequest(String id, bool toDelete) async {
    String message = await firebaseService.updateDeleteRequest(id, toDelete);
    print(message);
    notifyListeners();
  }

  void setEntryCount(int count) {
    _entryCount = count;
  }

  bool hasEntryToday() {
    var out = false;

    

    return out;
  }
}
