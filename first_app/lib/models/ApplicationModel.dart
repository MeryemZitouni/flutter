class ApplicationModel {
  ApplicationModel({
    this.status,
    this.meetUrl,
    this.studentId,
    this.requirementId,
    this.date,
  });

  String? status;
  String? requirementId;
  String? studentId;
  String? meetUrl;
  DateTime? date;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        status: json["status"],
        meetUrl: json["meetUrl"],
        requirementId: json["requirementId"],
        studentId: json["studentId"],
        date: json["date"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "status": "pending",
        "meetUrl": meetUrl,
        "studentId": studentId,
        "requirementId": requirementId,
        "date": DateTime.now(),
      };
}
