import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String userType;
  String email;
  String name;
  String username;
  String? college;
  String? course;
  String? studentnum;
  List<dynamic>? illnesses;
  String? allergies;
  Timestamp? latestEntryDate;
  Timestamp date;

  User({
    this.id,
    required this.email,
    required this.userType,
    required this.name,
    required this.username,
    this.college,
    this.course,
    this.studentnum,
    this.illnesses,
    this.allergies,
    this.latestEntryDate,
    required this.date,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        userType: json['userType'],
        email: json['email'],
        name: json['name'],
        username: json['username'],
        college: json['college'],
        course: json['course'],
        studentnum: json['studentnum'],
        illnesses: json['illnesses'],
        allergies: json['allergies'],
        latestEntryDate: json['latestEntryDate'],
        date: json['date'],
        );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'userType': user.userType,
      'email': user.email,
      'name': user.name,
      'username': user.username,
      'college': user.college,
      'course': user.course,
      'studentnum': user.studentnum,
      'illnesses': user.illnesses,
      'allergies': user.allergies,
      'latestEntryDate': user.latestEntryDate,
      'date': user.date,
    };
  }

}