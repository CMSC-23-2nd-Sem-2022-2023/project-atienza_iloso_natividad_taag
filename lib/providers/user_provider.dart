import 'package:flutter/material.dart';
import '../api/firebase_user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _usersStream;

  UserProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
  }
  Stream<QuerySnapshot> get users => _usersStream;

  fetchUsers() {
    _usersStream = firebaseService.getAllStudents();
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

}
