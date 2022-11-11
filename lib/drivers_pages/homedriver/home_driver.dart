import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/drivers_pages/driver_information.dart';
import 'package:my_zupco/inspector_pages/drivers.dart';
import 'package:my_zupco/models/ZupcoModel.dart';
import 'package:my_zupco/pages/details.dart';


import '../../components/constants.dart';

import '../../models/UserModel.dart';
import '../../pages/map.dart';
import '../../welcome_screen/welcome_screen.dart';

class DriverHomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const DriverHomePage(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel currentUser = UserModel();
  ZupcoModel currentZupco = ZupcoModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users/${user?.uid}/zupcoDetails")
        .doc(user?.uid)
        .get()
        .then((value) => currentZupco = ZupcoModel.fromMap(value.data()));
    setState(() {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          LineIcons.bars,
          color: kPrimaryColor2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Row(
                children: [
                  Text(
                    "Log out",
                    style: GoogleFonts.poppins(color: mainPrimaryColor),
                  ),
                  const SizedBox(
                    height: 35,
                    width: 35,
                    child: Icon(
                      LineIcons.doorOpen,
                      size: 30,
                      color: mainPrimaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _showConfirmationDialog(context);
              },
            ),
          )
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(" Welcome, Driver",
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 30)),
            const SizedBox(height: 12),
            Text("Your Zupco Details",
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 24)),
            const SizedBox(height: 20),
            //Zupco Details
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: mainPrimaryColor,
                          radius: 50,
                          child: Icon(
                            LineIcons.user,
                            size: 20,
                            color: altPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.001,
                      ),
                      Text("${currentZupco.driver}",
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: mainPrimaryColor,
                          radius: 50,
                          child: Icon(
                            LineIcons.bus,
                            size: 20,
                            color: altPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.001,
                      ),
                      Text("${currentZupco.vehicleNo}",
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: mainPrimaryColor,
                          radius: 50,
                          child: Icon(
                            LineIcons.building,
                            size: 20,
                            color: altPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.001,
                      ),
                      Text("${currentZupco.companyName}",
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: mainPrimaryColor,
                          radius: 50,
                          child: Icon(
                            LineIcons.hashtag,
                            size: 20,
                            color: altPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.001,
                      ),
                      Text("${currentZupco.regNo}",
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // ignore: prefer_collection_literals
                        return const Maps();
                      },
                    ),
                  );
                },
                child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            opacity: 80,
                            image: AssetImage("assets/maps/map.png"),
                            fit: BoxFit.cover),
                        color: kPrimaryColor2,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Current Location".toUpperCase(),
                              style: GoogleFonts.lato(
                                  color: altPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(height: size.width * 0.05),
                          const Icon(
                            LineIcons.arrowCircleRight,
                            color: altPrimaryColor,
                          )
                        ],
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SafeArea(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RouteDetails();
                        },
                      ),
                    );
                  },
                  child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor2,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text("Plan Route",
                              style: GoogleFonts.lato(
                                  color: altPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DriverInformation();
                          },
                        ),
                      );
                    },
                    child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.45,
                        decoration: const BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: Text("Update Details",
                                style: GoogleFonts.lato(
                                    color: altPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))))),
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(08),
                color: kPrimaryColor2,
                child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DriverTrips();
                          },
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "View Scheduled Trips",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: altPrimaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          LineIcons.busAlt,
                          color: altPrimaryColor,
                        )
                      ],
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Log out"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.popUntil(context, (route) => route.isFirst);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const WelcomeScreen();
                    }),
                  );
                },
              ),
            ],
            content: SizedBox(
              height: 190,
              width: 98,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 40),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(LineIcons.questionCircleAlt),
                      ),
                    ),
                    Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
