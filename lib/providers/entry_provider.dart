import 'package:flutter/material.dart';
import '../api/firebase_entry_api.dart';
import '../models/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entriesStream;
  late Stream<QuerySnapshot> _requestEditStream;
  late Stream<QuerySnapshot> _requestDeleteStream;

  int? _entryCount;
  List<QueryDocumentSnapshot<Object?>>? _currentUserEntries;
  Entry? _cUserLatestEntry;

  EntryProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntries();
    fetchEditRequests();
    fetchDeleteRequests();
  }

  Stream<QuerySnapshot> get entries => _entriesStream;
  Stream<QuerySnapshot> get editRequests => _requestEditStream;
  Stream<QuerySnapshot> get deleteRequests => _requestDeleteStream;
  int? get entryCount => _entryCount;
  List<QueryDocumentSnapshot<Object?>>? get currentUserEntries => _currentUserEntries;
  Entry? get cUserLatestEntry => _cUserLatestEntry;

  fetchEntries() {
    _entriesStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  fetchEditRequests() {
    _requestEditStream = firebaseService.getAllEditRequests();
    notifyListeners();
  }

  fetchDeleteRequests() {
    _requestDeleteStream = firebaseService.getAllDeleteRequests();
    notifyListeners();
  }

  void addEntry(Entry entry) async {
    String message = await firebaseService.addEntry(entry.toJson(entry));
    _entryCount = _entryCount! + 1;
    // ignore: avoid_print
    print(message);
    notifyListeners();
  }

  void deleteEntry(String id) async {
    String message = await firebaseService.deleteEntry(id);
    print(message);
    notifyListeners();
  }

  void createEditRequest(EntryEditRequest entry) async {
    String message =
        await firebaseService.createEditRequest(entry.toJson(entry));
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

  void makeDeleteRequest(String id, bool toDelete) async {
    String message = await firebaseService.updateDeleteRequest(id, toDelete);
    print(message);
    notifyListeners();
  }

  Future<Entry?> getLatestEntryForUid(String uid) async {
    final snapshot = await firebaseService.getAllEntries().first;
    final entries = snapshot.docs;
    Entry? latestEntry;

    for (var doc in entries) {
      final entry = Entry.fromJson(doc.data() as Map<String, dynamic>);
      if (entry.uid == uid) {
        if (latestEntry == null || entry.date.compareTo(latestEntry.date) > 0) {
          latestEntry = entry;
        }
      }
    }

    return latestEntry;
  }

  
  void setEntryCount(int count) {
    _entryCount = count;
  }

  void setCurrentUserEntries(List<QueryDocumentSnapshot<Object?>> entries) {
    _currentUserEntries = entries;
  }

  void setCUserLatestEntry(Entry entry) {
    _cUserLatestEntry = entry;
  }

  bool hasEntryToday() {
    var out = false;

    return out;
  }
}
