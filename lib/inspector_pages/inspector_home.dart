import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:my_zupco/inspector_pages/current_trips.dart';
import 'package:my_zupco/models/ZupcoModel.dart';
import '../../components/constants.dart';
import '../../models/UserModel.dart';

import '../../welcome_screen/welcome_screen.dart';

class InspectorHomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const InspectorHomePage(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<InspectorHomePage> createState() => _InspectorHomePageState();
}

class _InspectorHomePageState extends State<InspectorHomePage> {
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

  @override
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
            Text(" Welcome, Inspector",
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 30)),
            const SizedBox(height: 12),

            const SizedBox(height: 20),
            //Zupco Details
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CurrentTrips();
                            },
                          ),
                        );
                      },
                      child: Container(
                          height: size.height * 0.15,
                          width: size.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  opacity: 0,
                                  image: AssetImage("assets/maps/map.png"),
                                  fit: BoxFit.cover),
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("View Current Trips".toUpperCase(),
                                    style: GoogleFonts.lato(
                                        color: altPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
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
