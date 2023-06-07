import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password);
    notifyListeners();
  }

  Future<void> addUser(
      String email,
      String name,
      String username,
      String college,
      String course,
      String studentnum,
      List<String> illnesses,
      String allergies,
      String status,
      String usertype,
      Timestamp date) async {
    await authService.addUser(
        email, name, username, college, course, studentnum, illnesses, allergies, status, usertype, date);
    //use the function in firebase_auth_api
    notifyListeners();
  }

  Future<void> addAdminEmonitor(String email, String name, String employeeno,
      String position, String homeunit) async {
    await authService.addAdminEmonitor(
        email, name, employeeno, position, homeunit);
    //use the function in firebase_auth_api
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
