class ZupcoModel {
  String? uid;
  String? driver;
  String? regNo;
  // ignore: prefer_typing_uninitialized_variables
  var vehicleNo;
  String? companyName;


  ZupcoModel({this.uid, this.companyName,this.regNo,this.driver,this.vehicleNo});
  ZupcoModel.fromMap(map) {
    uid = map["uid"];
    driver = map["driver"];
    regNo = map["zupcoNumber"];
    vehicleNo=map["vehicleNo"];
    companyName=map["companyName"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "driver": driver,
      "zupcoNumber": regNo,
      "vehicleNo":vehicleNo,
      "companyName":companyName
    };
  }
}