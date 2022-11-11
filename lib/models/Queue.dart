// ignore: file_names

class QueueModel {

   int? currentPassengers = 0 ;



  QueueModel({this.currentPassengers});
  QueueModel.fromMap(map) {
   
    currentPassengers = map["currentPassengers"];
   
  }

  Map<String, dynamic> toMap() {
    return {
   
      "currentPassengers": currentPassengers,
  
    };
  }
}