import 'dart:convert';
import 'package:intl/intl.dart';

class User {
  String? id;
  String email;
  String name;
  String username;
  String? college;
  String? course;
  String? studentnum;
  List<dynamic>? illnesses;
  String? allergies;
  String? category;
  String? usertype; 
  String? date;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    this.college,
    this.course,
    this.studentnum,
    this.illnesses,
    this.allergies,
    this.category,
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
        category: json['category'],
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
      'category': user.category,
      'usertype': user.usertype,
      'date': user.date
    };
  }

  static List<User> userList() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return [
      User(
        email: "annatividad@up.edu.ph",
        name: "Aira Nicole",
        username: "airanatividad",
        college: "CAS",
        course: "BSCS",
        studentnum: "2021-12345",
        illnesses: [],
        allergies: "None",
        category: "safe",
        usertype: "default",
        date: formattedDate),
    ];
  }
}