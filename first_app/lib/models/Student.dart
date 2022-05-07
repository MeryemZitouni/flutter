// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

class Student {
  Student({
    this.firstName,
    this.lastName,
    this.email,
    this.instLevel,
    this.url,
    this.cv,
    this.role,
    required this.uid,
  });

  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? instLevel;
  String? cv;
  String? url;
  String? role;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        instLevel: json["instLevel"],
        cv: json["cv"],
        url: json["url"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "instLevel": instLevel,
        "cv": cv,
        "url": url,
        "role": role,
      };
}
