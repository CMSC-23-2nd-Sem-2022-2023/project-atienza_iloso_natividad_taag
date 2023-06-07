import 'dart:convert';
import 'package:intl/intl.dart';

class User {
  String? id;
  String email;
  String name;
  String username;
  String college;
  String course;
  String studentnum;
  List<dynamic>? illnesses;
  String? allergies;
  String? status;
  String? usertype; 
  String? date;

  int compareTo(User other) => name.compareTo(other.name);

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.college,
    required this.course,
    required this.studentnum,
    this.illnesses,
    this.allergies,
    this.status,
    this.usertype,
    this.date
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        username: json['username'],
        college: json['college'],
        course: json['course'],
        studentnum: json['studentnum'],
        illnesses: json['illnesses'],
        allergies: json['allergies'],
        status: json['status'],
        usertype: json['usertype'],
        date: json['date']
        );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'username': user.username,
      'college': user.college,
      'course': user.course,
      'studentnum': user.studentnum,
      'illnesses': user.illnesses,
      'allergies': user.allergies,
      'status': user.status,
      'usertype': user.usertype,
      'date': user.date
    };
  }
}