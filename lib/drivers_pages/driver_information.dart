// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';

import 'package:my_zupco/models/ZupcoModel.dart';

import '../components/constants.dart';
import '../models/UIHelper.dart';

class DriverInformation extends StatefulWidget {
  const DriverInformation({Key? key}) : super(key: key);

  @override
  State<DriverInformation> createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  final _auth = FirebaseAuth.instance;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController taxiNumberPlateController = TextEditingController();
  TextEditingController zupcoRegNoController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void saveDetails() {
    String destination = companyNameController.text.trim();
    String passenger = driverNameController.text.trim();
    String location = taxiNumberPlateController.text.trim();
    String zupco = zupcoRegNoController.text.trim();

    if (destination == "" || location == "" || passenger == "" || zupco == "") {
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

  save() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ZupcoModel details = ZupcoModel();

    //Adding the route details to the firebase

    try {
      details.uid = user?.uid;
      details.driver = user?.uid;
      details.companyName = companyNameController.text;
      details.driver = driverNameController.text;
      details.vehicleNo = taxiNumberPlateController.text;
      details.regNo = zupcoRegNoController.text;

      await firebaseFirestore
          .collection('users/${user?.uid}/zupcoDetails')
          .doc(details.uid)
          .set(details.toMap());

      UIHelper.showAlertDialog(
        context,
        "Success",
        "Driver Information Updated",
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        elevation: 0,
        title: Text(
          "Information",
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
                TextFormField(
                    autofocus: false,
                    controller: driverNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Driver's name",
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
                    controller: companyNameController,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Company Name",
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
                    controller: taxiNumberPlateController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Vehicle Reg No.",
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
                    controller: zupcoRegNoController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Zupco Reg No.",
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
                          saveDetails();
                        },
                        child: const Text(
                          "Update",
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
}
