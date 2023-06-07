import 'package:flutter/material.dart';
import '../api/firebase_entry_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _requestEditStream;
  late Stream<QuerySnapshot> _requestDeleteStream;

  EntryProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEditRequests();
    fetchDeleteRequests();
  }

  Stream<QuerySnapshot> get editRequests => _requestEditStream;
  Stream<QuerySnapshot> get deleteRequests => _requestDeleteStream;

  fetchEditRequests() {
    _requestEditStream = firebaseService.getAllEditRequests();
    notifyListeners();
  }

  fetchDeleteRequests() {
    _requestDeleteStream = firebaseService.getAllDeleteRequests();
    notifyListeners();
  }

  void editEntry(String id, List<String> entry) async {
    String message = await firebaseService.editEntry(id, entry);
    print(message);
    notifyListeners();
  }

  void deleteEntry(String id) async {
    String message = await firebaseService.deleteEntry(id);
    print(message);
    notifyListeners();
  }

  void updateToDelete(String id) async {
    String message = await firebaseService.updateToDelete(id);
    print(message);
    notifyListeners();
  }

  void updateToEdit(String id) async {
    String message = await firebaseService.updateToEdit(id);
    print(message);
    notifyListeners();
  }

  // void updateStudentNo(String id, String studentnum) async {
  //   String message = await firebaseService.updateStudentNo(id, studentnum);
  //   print(message);
  //   notifyListeners();
  // }
}
