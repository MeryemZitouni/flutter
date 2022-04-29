import 'dart:convert';

Recruteur recruteurFromJson(String str) => Recruteur.fromJson(json.decode(str));

String recruteurToJson(Recruteur data) => json.encode(data.toJson());

class Recruteur {
  Recruteur({
    this.companyName,
    this.logoUrl,
    this.location,
    this.emailr,
    required this.uid,
  });

  String? uid;
  String? companyName;
  String? logoUrl;
  String? location;
  String? emailr;

  factory Recruteur.fromJson(Map<String, dynamic> json) => Recruteur(
        uid: json["uid"],
        companyName: json["first_name"],
        logoUrl: json["last_name"],
        location: json["inst_level"],
        emailr: json["emailr"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "company_name": companyName,
        "logo_url": logoUrl,
        "location": location,
        "emailr": emailr,
      };
}
