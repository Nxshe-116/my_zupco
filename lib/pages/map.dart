import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';

import '../components/constants.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  //final geolocator.Geolocator _geolocator = geolocator.Geolocator();
  // For storing the current position

  late double originLatitude, originLongitude, destLatitude, destLongitude;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late GoogleMapController controller;
  final Location _location = Location();
  String googleAPiKey = "AIzaSyABNQrasXuezu61M2etHtEPFSuYLqs2i3U";

  @override
  void initState() {
    super.initState();

    /// origin marker
    addMarker(LatLng(originLatitude, originLongitude), "origin",
        BitmapDescriptor.defaultMarker);
  }

  void _onMapCreated(GoogleMapController cntlr) {
    controller = cntlr;
    _location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController addressController = TextEditingController();
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
      ),
      Positioned(
        left: 0,
        top: 0,
        right: 0,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x88999999),
                        offset: Offset(0, 5),
                        blurRadius: 5.0)
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                                width: 50.0,
                                child: Center(
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: altPrimaryColor),
                                      child: const Icon(
                                        LineIcons.search,
                                        color: kPrimaryColor2,
                                      )),
                                ),
                              ),
                              const Positioned(
                                right: 0,
                                top: 0,
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.close,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, right: 50.0, top: 14),
                                      child: TextField(
                                        style: const TextStyle(fontSize: 16),
                                        controller: addressController,
                                        textInputAction: TextInputAction.search,
                                        onChanged: (str) {},
                                        decoration: const InputDecoration
                                                .collapsed(
                                            hintText:
                                                "Set Destination, Search Driver"),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Container(
              color: altPrimaryColor,
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Hokay'),
                ],
              ),
            )
          ],
        ),
      ),
    ]));
  }

  addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: kPrimaryColor, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(originLatitude, originLongitude),
        PointLatLng(destLatitude, destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Harare")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine();
  }
}
