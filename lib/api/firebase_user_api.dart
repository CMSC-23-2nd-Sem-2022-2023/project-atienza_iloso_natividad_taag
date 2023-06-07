import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllStudents() {
    return db.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getQuarantined() {
    return db.collection("users").where("status", isEqualTo: "Under Quarantine").snapshots();
  }

  Stream<QuerySnapshot> getUnderMonitoring() {
    return db.collection("users").where("status", isEqualTo: "Under Monitoring").snapshots();
  }

  Future<String> deleteEntry(String? id) async {
    try {
      await db.collection("users").doc(id).delete();

      return "Successfully deleted student!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateStatus(
      String? id, String status) async {
    try {
      await db.collection("users").doc(id).update({"status": status});

      return "Successfully updated status!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateUserType(String? id, String email, String name, String usertype) async {
    try {
      // add user to admin/monitor collection
      // add only email, name
      await db.collection("admin_emonitors").add({'email': email, 'name': name, 'usertype': usertype});

      // delete user from users collection
      await db.collection("users").doc(id).delete();
      return "Successfully updated user type!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
