class Recruteur {
  Recruteur({
    this.companyName,
    this.logoUrl,
    this.location,
    this.emailr,
    this.role,
    required this.uid,
  });

  String? uid;
  String? role;
  String? companyName;
  String? logoUrl;
  String? location;
  String? emailr;

  factory Recruteur.fromJson(Map<String, dynamic> json) => Recruteur(
        uid: json["uid"],
        companyName: json["companyName"],
        logoUrl: json["logoUrl"],
        location: json["location"],
        emailr: json["emailr"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "companyName": companyName,
        "logoUrl": logoUrl,
        "location": location,
        "emailr": emailr,
        "role": role,
      };
}
