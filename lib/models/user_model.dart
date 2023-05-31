import 'dart:convert';

class User {
  String? id;
  String email;
  String name;
  String username;
  String college;
  String course;
  String studentnum;
  List<String> illnesses;
  String allergies;
  bool toEdit;
  bool toDelete;
  String date;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.college,
    required this.course,
    required this.studentnum,
    required this.illnesses,
    required this.allergies,
    required this.toEdit,
    required this.toDelete,
    required this.date
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
        toEdit: json['toEdit'],
        toDelete: json['toDelete'],
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
      'toEdit': user.toEdit,
      'toDelete': user.toDelete,
      'date': user.date
    };
  }

  static List<User> userList() {
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
        toEdit: false,
        toDelete: false,
        date: ""),
    ];
  }
}