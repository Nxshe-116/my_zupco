// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/ReportModel.dart';

import '../../components/constants.dart';
import '../../models/UIHelper.dart';
import '../../models/UserModel.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String? selectedValue;
  final _auth = FirebaseAuth.instance;
  TextEditingController reportController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  saveDestination() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ReportModel details = ReportModel();

    //Adding the route details to the firebase

    try {
      details.uid = user?.uid;
      details.description = reportController.text;
      details.report = selectedValue;

      await firebaseFirestore
          .collection('reports')
          .doc(details.uid)
          .set(details.toMap());

      UIHelper.showAlertDialog(
        context,
        "Success",
        "Your report has been submitted",
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
          backgroundColor: altPrimaryColor,
          elevation: 0,
          title: Text(
            "Report a Fault",
            style: GoogleFonts.poppins(color: kPrimaryColor2, fontSize: 23),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              LineIcons.arrowLeft,
              color: kPrimaryColor2,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text("Where is the fault: "),
                      SizedBox(
                        width: size.width * 0.34,
                      ),
                      DropdownButton(
                        value: selectedValue,
                        items: dropdownItems,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      )
                    ],
                  ),
                  TextFormField(
                      autofocus: false,
                      controller: reportController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter a meesage");
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        label: const Text("Description"),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Describe your fault",
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
                      )),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Column(
                    children: [
                      Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            onTap: () {
                              saveDestination();
                            },
                            contentPadding:
                                const EdgeInsets.only(right: 30, left: 36),
                            title: Text(
                              "Submit".toUpperCase(),
                              style: GoogleFonts.poppins(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            leading: const Icon(
                              LineIcons.paperPlane,
                              color: kPrimaryColor2,
                              size: 30,
                            ),
                          )),
                    ],
                  )
                ])));
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Transport", child: Text("Transport")),
    const DropdownMenuItem(value: "Application", child: Text("Application")),
    const DropdownMenuItem(value: "Driver", child: Text("Driver")),
    const DropdownMenuItem(value: "Route", child: Text("Route")),
  ];
  return menuItems;
}
