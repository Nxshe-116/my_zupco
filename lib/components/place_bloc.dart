import 'dart:async';


import '../repository/place_service.dart';

class PlaceBloc {
  final _placeController = StreamController.broadcast();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((rs) {
      _placeController.sink.add(rs);
    // ignore: argument_type_not_assignable_to_error_handler
    }).catchError(() {
      //sink stop
    });
  }

  void dispose() {
    _placeController.close();
  }
}