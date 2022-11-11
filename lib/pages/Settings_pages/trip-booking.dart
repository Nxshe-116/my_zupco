// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:my_zupco/pages/payments.dart';

import '../../components/constants.dart';
import '../../models/UIHelper.dart';
import '../../models/UserModel.dart';

class TripBooking extends StatefulWidget {
  const TripBooking({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TripBookingState createState() => _TripBookingState();
}

class _TripBookingState extends State<TripBooking> {
  final _auth = FirebaseAuth.instance;
  TextEditingController destinationController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  DateTime dateTime = DateTime.now();
  String? response;

  saveDestination() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserDetails details = UserDetails();

    //Adding the route details to the firebase

    try {
      details.uid = user?.uid;
      details.destination = destinationController.text;
      details.dateofTrip = dateTime;
      details.numOfTravellers = numberController.text;
      details.packages = response == 'yes' ? true : false;

      await firebaseFirestore
          .collection('users/${user?.uid}/destination')
          .doc(details.uid)
          .set(details.toMap());

      UIHelper.showAlertDialog(
        context,
        "Success",
        "Trip Booked Successfully",
      );
    } on Exception catch (e) {
      UIHelper.showAlertDialog(
        context,
        "Failed $e",
        "Something went wrong!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor2,
          elevation: 0,
          title: Text(
            "Intercity Travel",
            style: GoogleFonts.poppins(color: altPrimaryColor, fontSize: 23),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              LineIcons.arrowLeft,
              color: altPrimaryColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        autofocus: false,
                        controller: destinationController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Enter Valid Destination");
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          label: const Text("1. Destination"),
                          labelStyle: GoogleFonts.poppins(color: Colors.grey),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor2, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor2, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor2, width: 15.0),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    TextFormField(
                        autofocus: false,
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Enter Valid Destination");
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          label: const Text("  2. Number of travellers"),
                          labelStyle: GoogleFonts.poppins(color: Colors.grey),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor2, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor2, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor2, width: 15.0),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      "3. Travelling date",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimaryColor2,
                          child: MaterialButton(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: MediaQuery.of(context).size.width * 0.2,
                              onPressed: pickDateTime,
                              child: const Icon(
                                LineIcons.calendar,
                                color: altPrimaryColor,
                              )),
                        ),
                        SizedBox(width: size.width * 0.07),
                        Text(
                          DateFormat().format(dateTime),
                          style: GoogleFonts.poppins(fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "4. Will you be carrying any heavy luggage?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                        RadioListTile(
                          title: const Text("Yes"),
                          value: "yes",
                          groupValue: response,
                          onChanged: (value) {
                            setState(() {
                              response = value as String?;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("No"),
                          value: "no",
                          groupValue: response,
                          onChanged: (value) {
                            setState(() {
                              response = value as String?;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                            color: Colors.white,
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Payments();
                                    },
                                  ),
                                );
                              },
                              contentPadding:
                                  const EdgeInsets.only(right: 30, left: 36),
                              title: Text(
                                "Next".toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text("Add Payment"),
                              leading: const Icon(
                                LineIcons.paperPlane,
                                color: kPrimaryColor2,
                                size: 30,
                              ),
                            )),
                      ],
                    )
                  ])),
        ));
  }

  pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    // ignore: unnecessary_null_comparison
    if (date == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time!.hour, time.minute);
    setState(() {
      this.dateTime = dateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
