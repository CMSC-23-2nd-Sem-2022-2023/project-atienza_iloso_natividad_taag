import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllStudents() {
    return db.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getQuarantined() {
    return db.collection("users").where("category", isEqualTo: "Quarantined").snapshots();
  }

  Stream<QuerySnapshot> getUnderMonitoring() {
    return db.collection("users").where("category", isEqualTo: "Under monitoring").snapshots();
  }

  Future<String> deleteEntry(String? id) async {
    try {
      await db.collection("users").doc(id).delete();

      return "Successfully deleted student!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> printSmth() async {
    try {
      return "printtt";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateEditRequest(
      String? id, bool toEdit) async {
    try {
      await db.collection("users").doc(id).update({"toEdit": toEdit});

      return "Successfully updated student request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateDeleteRequest(String? id, bool toDelete) async {
    try {
      await db.collection("users").doc(id).update({"toDelete": toDelete});

      return "Successfully updated student request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
