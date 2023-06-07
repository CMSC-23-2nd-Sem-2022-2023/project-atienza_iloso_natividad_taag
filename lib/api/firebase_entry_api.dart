import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllEntries() {
    return db.collection("entries").orderBy('date', descending: true).snapshots();
  }

  // get all edit requests
  Stream<QuerySnapshot> getAllEditRequests() {
    return db.collection("entries").where("toEdit", isEqualTo: true).snapshots();
  }

  // get all delete requests
  Stream<QuerySnapshot> getAllDeleteRequests() {
    return db.collection("entries").where("toDelete", isEqualTo: true).snapshots();
  }

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      await db.collection("entries").add(entry);

      return "Successfully added entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editEntry(String id, Map<String, dynamic> entry) async {
    try {
      await db.collection("friendList").doc(id).update(entry);

      return "Successfully edited entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }


  Future<String> deleteEntry(String? id) async {
    try {
      await db.collection("entries").doc(id).delete();

      return "Successfully deleted entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateEditRequest(
      String? id, bool toEdit) async {
    try {
      await db.collection("entries").doc(id).update({"toEdit": toEdit});

      return "Successfully updated entry request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateDeleteRequest(String? id, bool toDelete) async {
    try {
      await db.collection("entries").doc(id).update({"toDelete": toDelete});

      return "Successfully updated entry request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
