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

  Future<void> signUp(String name, String email, String password) async {
    await authService.signUp(name, email, password);
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
      String date) async {
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

  void setCurrentUser(User user) {
    _cUser = user;
    // notifyListeners();
  }


  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
