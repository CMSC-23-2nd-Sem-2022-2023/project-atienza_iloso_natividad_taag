import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllEntries() {
    return db.collection("entries").snapshots();
  }

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      await db.collection("entries").add(entry);

      return "Successfully added entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteUser(String? id) async {
    try {
      await db.collection("users").doc(id).delete();

      return "Successfully deleted student!";
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
