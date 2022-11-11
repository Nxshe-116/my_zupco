import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/UserModel.dart';

import '../components/constants.dart';

class BookedTrips extends StatefulWidget {
  const BookedTrips({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookedTripsState createState() => _BookedTripsState();
}
UserModel currentUser = UserModel();
class _BookedTripsState extends State<BookedTrips> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Booked Trips",
          style: GoogleFonts.poppins(color: kPrimaryColor2, fontSize: 22),
        ),
        centerTitle: true,
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
              StreamBuilder<List<UserDetails>>(
                stream: getTripDetails(),
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

  Stream<List<UserDetails>> getTripDetails() => FirebaseFirestore.instance
      .collection('users/${currentUser.uid}/destination')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserDetails.fromMap(doc.data())).toList());

  Widget buildDetails(UserDetails model) => GestureDetector(
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
                        Text(model.packages.toString())
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
                        Text("${model.numOfTravellers}")
                      ],
                    ),
                    const SizedBox(
                      width: 10,
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
                    Text(model.dateofTrip.toString())
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
