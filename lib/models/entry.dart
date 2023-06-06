import 'dart:convert';

class Entry{
  String? id;
  String date;
  String uid;
  Map<String, dynamic> illnesses;

  Entry(
    {
      this.id,
      required this.date,
      required this.uid,
      required this.illnesses,
    }
  );

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        date: json['date'],
        uid: json['uid'],
        illnesses: json['illnesses'],
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
    };
  }
}