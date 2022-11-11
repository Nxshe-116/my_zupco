// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/RouteDetailsModel.dart';
import 'package:my_zupco/models/ZupcoModel.dart';

import '../components/constants.dart';
import '../models/UIHelper.dart';

class RouteDetails extends StatefulWidget {
  const RouteDetails({Key? key}) : super(key: key);

  @override
  State<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  User? user = FirebaseAuth.instance.currentUser;

  ZupcoModel currentDriver = ZupcoModel();
  final _auth = FirebaseAuth.instance;
  TextEditingController destinationController = TextEditingController();
  TextEditingController passengersController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void saveDetails() {
    String destination = destinationController.text.trim();
    var passenger = passengersController;
    String location = locationController.text.trim();

    if (destination == "" || location == "") {
      UIHelper.showAlertDialog(
        context,
        "Incomplete Data",
        "Please fill all the fields",
      );
    } else {
      if (kDebugMode) {
        print("zvaita");
      }
      save();
    }
  }

  Future<void> save() async {
    try {
      _auth;
      saveToFireStore();
    } on FirebaseException catch (erroe) {
      if (kDebugMode) {
        print(erroe);
      }
    }
  }

  saveToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    RouteDetailsModel details = RouteDetailsModel();

    //Adding the route details to the firebase

    try {
      details.uid = user?.uid;
      details.driver = currentDriver.driver;
      details.passengers = passengersController.text;
      details.busStopLocation = locationController.text;
      details.arrivalTime = dateTime;
      details.destination = destinationController.text;

      await firebaseFirestore
          .collection('routeDetails')
          .doc('destination: ${destinationController.text}')
          .set(details.toMap());

      UIHelper.showAlertDialog(
        context,
        "Success",
        "Route Successfully Saved",
      );
    } on Exception catch (e) {
      // TODO
      UIHelper.showAlertDialog(
        context,
        "Failed $e",
        "Something went wrong!",
      );
    }
  }

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users/${user?.uid}/zupcoDetails")
        .doc(user?.uid)
        .get()
        .then((value) => currentDriver = ZupcoModel.fromMap(value.data()));
    setState(() {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        elevation: 0,
        title: Text(
          "Route Details",
          style: GoogleFonts.poppins(color: altPrimaryColor, fontSize: 20),
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
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.09),
                Image.asset(
                  "assets/navigation.png",
                  height: 250,
                  width: 250,
                ),
                TextFormField(
                    autofocus: false,
                    controller: destinationController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Destination",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
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
                    ),
                    onChanged: (value) {}),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                    controller: passengersController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Number of Passengers",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
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
                    ),
                    onChanged: (value) {}),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                    autofocus: false,
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Bus-Stop Location",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
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
                    ),
                    onChanged: (value) {}),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor2,
                      child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                SizedBox(height: size.height * 0.09),
                SizedBox(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor2,
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          saveToFireStore();
                        },
                        child: const Text(
                          "Save Route",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: altPrimaryColor,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
