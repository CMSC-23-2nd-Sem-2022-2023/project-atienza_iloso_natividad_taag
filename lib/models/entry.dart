import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Entry{
  String? id;
  Timestamp date;
  String uid;
  Map<String, dynamic> illnesses;
  bool? toEdit;
  bool? toDelete;

  Entry(
    {
      this.id,
      required this.date,
      required this.uid,
      required this.illnesses,
      this.toEdit = false,
      this.toDelete = false,
    }
  );

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        date: json['date'],
        uid: json['uid'],
        illnesses: json['illnesses'],
        toEdit: json['toEdit'],
        toDelete: json['toDelete'],
        );
  }

  static List<Entry> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Entry>((dynamic d) => Entry.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Entry entry) {
    return {
      'id': entry.id,
      'date': entry.date,
      'uid': entry.uid,
      'illnesses': entry.illnesses,
      'toEdit': entry.toEdit,
      'toDelete': entry.toDelete,
    };
  }
}