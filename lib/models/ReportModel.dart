class ReportModel {
  String? uid;
  String? description;
  String? report;

  ReportModel({this.uid, this.report, this.description});

  ReportModel.fromMap(map) {
    uid = map["uid"];
    description = map["reportMessage"];
    report = map["report"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "reportMessage": description,
      "report":report 
    };
  }
}
