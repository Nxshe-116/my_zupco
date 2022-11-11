import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/pages/Settings_pages/reports.dart';

import '../components/constants.dart';

import '../models/UserModel.dart';
import '../welcome_screen/welcome_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundColor: mainPrimaryColor,
                    radius: 60,
                    child: Icon(
                      LineIcons.user,
                      size: 60,
                      color: altPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Passenger",
                            style: GoogleFonts.poppins(
                                color: kPrimaryColor, fontSize: 32)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor2,
                child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      "Manage Account Settings".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          color: altPrimaryColor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Column(
              children: [
                Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Reports();
                            },
                          ),
                        );
                      },
                      contentPadding:
                          const EdgeInsets.only(right: 30, left: 36),
                      title: Text(
                        "Report a fault".toUpperCase(),
                        style: GoogleFonts.poppins(
                            color: kPrimaryColor, fontWeight: FontWeight.w700),
                      ),
                      leading: const Icon(
                        LineIcons.exclamationCircle,
                        color: kPrimaryColor2,
                        size: 30,
                      ),
                    )),
                SizedBox(
                  width: size.width,
                  child: Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          _showConfirmationDialog(context);
                        },
                        subtitle: Text(
                          "Sign out of your Account",
                          style: GoogleFonts.poppins(color: kPrimaryColor2),
                        ),
                        contentPadding:
                            const EdgeInsets.only(right: 30, left: 36),
                        title: Text(
                          "Log out".toUpperCase(),
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                        leading: const Icon(
                          LineIcons.alternateSignOut,
                          color: kPrimaryColor2,
                          size: 30,
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
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
