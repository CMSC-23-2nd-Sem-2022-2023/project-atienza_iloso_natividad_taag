import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<void> signIn(String email, String password) async {
    try {
      final UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String> signUp(String name, String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.\

      User? user = result.user;
      if (user != null) {
        // Set display name and email for the user
        user.updateDisplayName(name);
        user = auth.currentUser;
        auth.signOut();

        // BAND-AID SOLUTION
      }

      return ('Success!');
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      // return('Fail!');
    }
    return ('Fail!');
  }

  Future<String> addUser({
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
    try {
      await db.collection("users").add({
        'email': email,
        'name': name,
        'username': username,
        'college': college,
        'course': course,
        'studentnum': studentnum,
        'illnesses': illnesses,
        'allergies': allergies,
        'status': status,
        'usertype': usertype,
        'date': date
      });

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> addAdminEmonitor(String email, String name, String employeeno,
      String position, String homeunit) async {
    try {
      await db.collection("admin_emonitors").add({
        'email': email,
        'name': name,
        'employeeno': employeeno,
        'position': position,
        'homeunit': homeunit,
      });

      return "Successfully added admin/emonitor!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }
}
