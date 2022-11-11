// ignore: file_names
class UserModel {
  String? uid;

  String? email;
  String? role;

  UserModel({this.uid, this.email, this.role});

  UserModel.fromMap(map) {
    uid = map["uid"];
    email = map["email"];
    role = map["role"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "role": role,
    };
  }
}

class UserDetails {
  String? uid;
  DateTime? dateofTrip;
  String? destination;
  bool? packages;
  var numOfTravellers;

  UserDetails(
      {this.uid,
      this.destination,
      this.dateofTrip,
      this.packages,
      this.numOfTravellers});

  UserDetails.fromMap(map) {
    uid = map["uid"];
    destination = map["destination"];
    dateofTrip = map["dateOfTrip"].toDate();
    packages = map["carreerBags"];
    numOfTravellers = map["numOfTravellers"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "destination": destination,
      "dateOfTrip": dateofTrip,
      "carreerBags":packages,
      "numOfTravellers": numOfTravellers

    };
  }
}
