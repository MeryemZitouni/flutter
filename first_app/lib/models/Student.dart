// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.firstName,
    this.lastName,
    this.email,
    this.instLevel,
    this.cv,
    required this.uid,
  });

  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? instLevel;
  String? cv;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        instLevel: json["inst_level"],
        cv: json["cv"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "inst_level": instLevel,
        "cv": cv,
      };
}
