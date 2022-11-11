import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/RouteDetailsModel.dart';

import '../components/constants.dart';

class DriverTrips extends StatefulWidget {
  const DriverTrips({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DriverTripsState createState() => _DriverTripsState();
}

class _DriverTripsState extends State<DriverTrips> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("On-Going Trips",
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

  // DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("users").doc(uid).get();

  Stream<List<RouteDetailsModel>> getTransport() => FirebaseFirestore.instance
      .collection('routeDetails')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RouteDetailsModel.fromMap(doc.data()))
          .toList());

  Widget buildDetails(RouteDetailsModel model) => GestureDetector(
        onTap: () {},
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
                Row(
                  children: const [Text("Status:"), Text("In progress")],
                )
              ],
            ),
          ),
        ),
      );
}
