import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  String? id;
  String email;
  String name;
  String username;
  String? college;
  String? course;
  String studentnum;
  String? status;
  String? location; 
  Timestamp date;

  int compareTo(Log other) => name.compareTo(other.name);

  Log({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.college,
    required this.course,
    required this.studentnum,
    this.status,
    this.location,
    required this.date
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        username: json['username'],
        college: json['college'],
        course: json['course'],
        studentnum: json['studentnum'],
        status: json['status'],
        location: json['location'],
        date: json['date']
        );
  }

  static List<Log> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Log>((dynamic d) => Log.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Log user) {
    return {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'username': user.username,
      'college': user.college,
      'course': user.course,
      'studentnum': user.studentnum,
      'status': user.status,
      'location': user.location,
      'date': user.date
    };
  }
}