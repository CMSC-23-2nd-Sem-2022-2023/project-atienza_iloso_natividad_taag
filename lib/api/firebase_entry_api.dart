import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllEditRequests() {
    return db.collection("entries").where("toEdit", isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> getAllDeleteRequests() {
    return db.collection("entries").where("toDelete", isEqualTo: true).snapshots();
  }

  Future<String> editEntry(String id, List<String> entry) async {
    try {
      await db.collection("entries").doc(id).update({ 'illnesses': entry });

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

  Future<String> updateToDelete(String id) async {
    try {
      await db.collection("entries").doc(id).update({ 'toDelete': false });

      return "Successfully edited entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateToEdit(String id) async {
    try {
      await db.collection("entries").doc(id).update({ 'toEdit': false });

      return "Successfully edited entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
