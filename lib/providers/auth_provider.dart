import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;
  // User? userObj;

  User? _cUser;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User get getCurrentUser => _cUser!;

  void fetchAuthentication() {
    _uStream = authService.getUser();

    notifyListeners();
  }

  Future<String> signUp(String name, String email, String password) async {
    String result = await authService.signUp(name, email, password);
    notifyListeners();
    return result;
  }

  Future<void> addUser({
    required String email,
    required String name,
    required String username,
    String? college,
    String? course,
    String? studentnum,
    List<String>? illnesses,
    String? allergies,
    required String status,
    required String usertype,
    required Timestamp date,
  }) async {
    await authService.addUser(
        email: email,
        name: name,
        username: username,
        college: college,
        course: course,
        studentnum: studentnum,
        illnesses: illnesses,
        allergies: allergies,
        status: status,
        usertype: usertype,
        date: date);
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

  void setCurrentUser(User user) {
    _cUser = user;
    // notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
