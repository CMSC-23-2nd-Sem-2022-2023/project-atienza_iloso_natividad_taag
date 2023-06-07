import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllLogs() {
    return db.collection("logs").snapshots();
  }

  Stream<QuerySnapshot> getQuarantined() {
    return db.collection("logs").where("status", isEqualTo: "Under Quarantine").snapshots();
  }

  Future<String> updateLog(
      String? id, String location, String status, String studentnum) async {
    try {
      await db.collection("logs").doc(id).update({"location": location, "status": status, "studentnum": studentnum});

      return "Successfully updated log!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // Future<String> updateStudentNo(
  //     String? id, String studentnum) async {
  //   try {
  //     await db.collection("logs").doc(id).update({"studentnum": studentnum});

  //     return "Successfully updated student number!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> updateStatus(
  //     String? id, String status) async {
  //   try {
  //     await db.collection("logs").doc(id).update({"status": status});

  //     return "Successfully updated status!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> updateUserType(String? id, String email, String name, String usertype) async {
  //   try {
  //     // add user to admin/monitor collection
  //     // add only email, name
  //     await db.collection("admin_emonitors").add({'email': email, 'name': name, 'usertype': usertype});

  //     // delete user from users collection
  //     await db.collection("users").doc(id).delete();
  //     return "Successfully updated user type!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }
}
