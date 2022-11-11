// ignore: file_names
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class RouteDetailsModel {
  String? uid;
  String? driver;
  String? destination;
  String? busStopLocation;
  var passengers;
  DateTime? arrivalTime;

  RouteDetailsModel(
      {this.uid,
      this.arrivalTime,
      this.busStopLocation,
      this.driver,
      this.passengers,
      this.destination});
  RouteDetailsModel.fromMap(map) {
    uid = map["uid"];
    driver = map["driver"];
    busStopLocation = map["location"];
    passengers = map["passengers"];
    arrivalTime = map["arrivalTime"].toDate();
    // arrivalTime= map[arrivalTime].data["duedate"].toDate();
    destination = map["destination"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "driver": driver,
      "location": busStopLocation,
      "passengers": passengers,
      "arrivalTime": arrivalTime,
      "destination": destination
    };
  }
}
