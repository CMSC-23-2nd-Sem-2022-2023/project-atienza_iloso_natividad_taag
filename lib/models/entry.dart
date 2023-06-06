import 'dart:convert';

class Entry{
  String? id;
  String date;
  String username;
  Map<String, dynamic> illnesses;

  Entry(
    {
      this.id,
      required this.date,
      required this.username,
      required this.illnesses,
    }
  );

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        date: json['date'],
        username: json['username'],
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
      'username': entry.username,
      'illnesses': entry.illnesses,
    };
  }

  static List<Entry> entryList(){
    return [
      Entry(id:'01', date:'05/25/2023', illnesses: {}, username: ''),
      Entry(id:'02', date:'05/24/2023', illnesses: {}, username: ''),
      Entry(id:'03', date:'05/23/2023', illnesses: {}, username: ''),
      Entry(id:'04', date:'05/22/2023', illnesses: {}, username: ''),
      Entry(id:'05', date:'05/21/2023', illnesses: {}, username: ''),
      Entry(id:'06', date:'05/20/2023', illnesses: {}, username: ''),
      Entry(id:'07', date:'05/19/2023', illnesses: {}, username: ''),
      Entry(id:'08', date:'05/18/2023', illnesses: {}, username: ''),
      Entry(id:'09', date:'05/217/2023', illnesses: {}, username: ''),
    ];
  }
}