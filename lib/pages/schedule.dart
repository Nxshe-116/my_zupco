import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/RouteDetailsModel.dart';

import '../components/constants.dart';

import '../models/UserModel.dart';
import 'join_queue.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Taxi Schedule",
                  style: GoogleFonts.lato(
                      color: kPrimaryColor2,
                      fontWeight: FontWeight.w600,
                      fontSize: 25)),
              SizedBox(height: size.height * 0.02),
              StreamBuilder<List<RouteDetailsModel>>(
                stream: getTransport(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something Went Wrong "));
                  } else if (snapshot.hasData) {
                    final schedule = snapshot.data!;

                    return ListView(
                      padding: const EdgeInsets.all(1),
                      shrinkWrap: true,
                      children: schedule.map(buildDetails).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<RouteDetailsModel>> getTransport() => FirebaseFirestore.instance
      .collection('routeDetails')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RouteDetailsModel.fromMap(doc.data()))
          .toList());

  Widget buildDetails(RouteDetailsModel model) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRoute(
              model.driver,
              model.destination,
              model.passengers,
              model.busStopLocation,
              model.arrivalTime,
              model.uid));
        },
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: const Icon(
              LineIcons.info,
              size: 30,
              color: mainPrimaryColor,
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Driver: ",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(model.driver!)
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Destination: ",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(model.destination!)
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Passengers: ",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text("${model.passengers}")
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Bus-Stop: ",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text("${model.busStopLocation}")
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Time of boarding: ",
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text("${model.arrivalTime}")
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

Route createRoute(driver, destination, passenger, busStop, time, id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => JoinQueue(
      busStop: busStop,
      driver: driver,
      time: time,
      destination: destination,
      passenger: passenger,
      routeID: id,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
