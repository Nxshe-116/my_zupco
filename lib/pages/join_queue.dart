// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/RouteDetailsModel.dart';
import 'package:my_zupco/models/Queue.dart';

import '../components/constants.dart';

import '../models/UIHelper.dart';
import '../models/ZupcoModel.dart';

class JoinQueue extends StatefulWidget {
  final String driver, destination, passenger, busStop;
  final DateTime time;

  final String routeID;

  const JoinQueue(
      {Key? key,
      required this.driver,
      required this.destination,
      required this.passenger,
      required this.busStop,
      required this.time,
      required this.routeID})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JoinQueueState createState() => _JoinQueueState();
}

class _JoinQueueState extends State<JoinQueue> {
  ZupcoModel currentZupco = ZupcoModel();
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final List<RouteDetailsModel> details = [];
  List<String> virtualQueue = <String>[];

  @override
  void AddtoQueue() {
    setState(() {
      virtualQueue.add(user!.uid);
      joinQueue();
    });
  }

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users/${widget.routeID}/zupcoDetails")
        .doc(widget.routeID)
        .get()
        .then((value) => currentZupco = ZupcoModel.fromMap(value.data()));
    setState(() {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        elevation: 0,
        title: Text(
          "Join Queue",
          style: GoogleFonts.poppins(
              color: altPrimaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 23),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LineIcons.arrowLeft,
            color: altPrimaryColor,
            size: 25.0,
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
            SizedBox(height: size.height * 0.035),
            Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: const BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("Driver",
                                            style: GoogleFonts.lato(
                                                color: altPrimaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 21)),
                                        SizedBox(
                                          height: size.height * 0.03,
                                        ),
                                        Text(widget.driver,
                                            style: GoogleFonts.lato(
                                                color: altPrimaryColor,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("Passengers",
                                              style: GoogleFonts.lato(
                                                  color: altPrimaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 21)),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Text(widget.passenger,
                                              style: GoogleFonts.lato(
                                                  color: altPrimaryColor,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("Destination",
                                            style: GoogleFonts.lato(
                                                color: altPrimaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 21)),
                                        SizedBox(
                                          height: size.height * 0.03,
                                        ),
                                        Text(widget.destination,
                                            style: GoogleFonts.lato(
                                                color: altPrimaryColor,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("Bus-Stop",
                                              style: GoogleFonts.lato(
                                                  color: altPrimaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 21)),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Text(widget.busStop,
                                              style: GoogleFonts.lato(
                                                  color: altPrimaryColor,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              height: 55,
            ),
            SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.driver}'s Taxi Details",
                        style: GoogleFonts.poppins(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "ZUPCO NO:",
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                          Text("ZW1234",
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "NUMBER PLATE:",
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                          Text("ABP 0980",
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "COMPANY:",
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                          Text("ZUPCO",
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ],
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Column(
              children: [
                Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        AddtoQueue();
                      },
                      subtitle: Text(
                        "Join Virtual Queue",
                        style: GoogleFonts.poppins(color: kPrimaryColor2),
                      ),
                      contentPadding:
                          const EdgeInsets.only(right: 30, left: 36),
                      title: Text(
                        "Join Queue".toUpperCase(),
                        style: GoogleFonts.poppins(
                            color: kPrimaryColor, fontWeight: FontWeight.w700),
                      ),
                      leading: const Icon(
                        LineIcons.bus,
                        color: kPrimaryColor2,
                        size: 30,
                      ),
                    )),
              ],
            )
          ],
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

  joinQueue() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QueueModel details = QueueModel();

    //Adding the route details to the firebase

    try {
      details.currentPassengers = virtualQueue.length;
      await firebaseFirestore
          .collection(
              'routeDetails/destination: ${widget.destination}/virtualQueue')
          .doc()
          .set(details.toMap());

      UIHelper.showAlertDialog(
        context,
        "Success",
        "You have been added to the queue",
      );
    } on Exception catch (e) {
      UIHelper.showAlertDialog(
        context,
        "Failed $e",
        "Something went wrong!",
      );
    }
  }
}
