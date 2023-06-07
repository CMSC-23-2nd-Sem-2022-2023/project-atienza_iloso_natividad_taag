import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? userType;
  String email;
  String name;
  String username;
  String? college;
  String? course;
  String? studentnum;
  String? employeeno;
  String? position;
  String? homeunit;
  List<dynamic>? illnesses;
  String? allergies;
  String? status;
  String? usertype; 
  Timestamp? latestEntryDate;
  Timestamp? date;

  int compareTo(User other) => name.compareTo(other.name);

  User({
    this.id,
    required this.email,
     this.userType,
    required this.name,
    required this.username,
    this.college,
    this.course,
    this.studentnum,
    this.employeeno,
    this.position,
    this.homeunit,
    this.illnesses,
    this.allergies,
    this.status,
    this.usertype,
    this.latestEntryDate,
    this.date,
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
        employeeno: json['employeeno'],
        position: json['position'],
        homeunit: json['homeunit'],
        illnesses: json['illnesses'],
        allergies: json['allergies'],
        status: json['status'],
        usertype: json['usertype'],
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
      'employeeno': user.employeeno,
      'position': user.position,
      'homeunit': user.homeunit,
      'illnesses': user.illnesses,
      'allergies': user.allergies,
      'status': user.status,
      'usertype': user.usertype,
      'latestEntryDate': user.latestEntryDate,
      'date': user.date,
    };
  }
}