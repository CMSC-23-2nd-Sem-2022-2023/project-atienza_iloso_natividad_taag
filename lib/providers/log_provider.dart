import 'package:flutter/material.dart';
import '../api/firebase_log_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _logStream;
  late Stream<QuerySnapshot> _quarantinedStream;

  LogProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
    fetchQuarantined();
  }

  Stream<QuerySnapshot> get logs => _logStream;
  Stream<QuerySnapshot> get underquarantine => _quarantinedStream;

  fetchUsers() {
    _logStream = firebaseService.getAllLogs();
    notifyListeners();
  }

  fetchQuarantined() {
    _quarantinedStream = firebaseService.getQuarantined();
    notifyListeners();
  }

  void updateStatus(String id, String status) async {
    String message = await firebaseService.updateStatus(id, status);
    print(message);
    notifyListeners();
  }

  void updateLocation(String id, String location) async {
    String message = await firebaseService.updateLocation(id, location);
    print(message);
    notifyListeners();
  }

  void updateStudentNo(String id, String studentnum) async {
    String message = await firebaseService.updateStudentNo(id, studentnum);
    print(message);
    notifyListeners();
  }
}
