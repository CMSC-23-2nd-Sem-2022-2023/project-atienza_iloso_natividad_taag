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
  Stream<QuerySnapshot> get underquarantine => _quarantinedStream;
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
  void updateStatus(String id, String status) async {
    String message = await firebaseService.updateStatus(id, status);
    print(message);
    notifyListeners();
  }

  void updateUserType(String id, String email, String name, String usertype) async {
    String message = await firebaseService.updateUserType(id, email, name, usertype);
    print(message);
    notifyListeners();
  }

}
