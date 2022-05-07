class Requirement {
  Requirement(
      {this.companyName,
      this.logoUrl,
      this.location,
      this.deadline,
      this.periode,
      this.profile,
      this.requirement,
      this.requirementId,
      this.appliers});

  String? companyName;
  String? requirementId;
  List? appliers;

  String? logoUrl;
  String? location;
  String? profile;
  String? periode;
  String? requirement;
  DateTime? deadline;

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        companyName: json["companyName"],
        logoUrl: json["logoUrl"],
        location: json["location"],
        requirement: json["requirement"],
        profile: json["profile"],
        deadline: json["deadline"].toDate(),
        periode: json["periode"],
        requirementId: json["requirementId"],
        appliers: json["appliers"],
      );

  Map<String, dynamic> toJson(String id) => {
        "companyName": companyName,
        "logoUrl": logoUrl,
        "location": location,
        "profile": profile,
        "deadline": deadline,
        "periode": periode,
        "requirement": requirement,
        "requirementId": id,
        "appliers": [],
      };
}
