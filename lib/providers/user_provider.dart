import 'package:flutter/material.dart';
import '../api/firebase_user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _entriesStream;
  late Stream<QuerySnapshot> _quarantinedStream;
  late Stream<QuerySnapshot> _undermonitoringStream;


  UserProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
    fetchQuarantined();
    fetchUnderMonitoring();
  }

  Stream<QuerySnapshot> get entries => _entriesStream;
  Stream<QuerySnapshot> get quarantined => _quarantinedStream;
  Stream<QuerySnapshot> get undermonitoring => _undermonitoringStream;

  fetchUsers() {
    _entriesStream = firebaseService.getAllStudents();
    notifyListeners();
  }

  fetchQuarantined() {
    _quarantinedStream = firebaseService.getQuarantined();
    notifyListeners();
  }

  fetchUnderMonitoring() {
    _undermonitoringStream = firebaseService.getUnderMonitoring();
    notifyListeners();
  }

  // edit entry in firebase
  void updateCategory(String id, String category) async {
    String message = await firebaseService.updateCategory(id, category);
    print(message);
    notifyListeners();
  }

  void updateDeleteRequest(String id, bool toDelete) async {
    String message = await firebaseService.updateDeleteRequest(id, toDelete);
    print(message);
    notifyListeners();
  }
}
