import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/models/UIHelper.dart';
import 'package:my_zupco/models/UserModel.dart';


import '../components/constants.dart';



class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}


class _PaymentsState extends State<Payments> {
  final _auth = FirebaseAuth.instance;


  TextEditingController destinationController = TextEditingController();

  TextEditingController numberController = TextEditingController();

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

      // ignore: use_build_context_synchronously
      _showConfirmationDialog(context);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        elevation: 0,
        title: Text(
          "Add Payment",
          style: GoogleFonts.poppins(color: altPrimaryColor, fontSize: 23),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LineIcons.arrowLeft,
            color: altPrimaryColor,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(
                15,
              ),
              height: 102,
              width: 375,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        backgroundColor: mainPrimaryColor,
                        radius: 30,
                        child: Center(
                          child: Center(
                              child: Icon(
                            LineIcons.creditCardAlt,
                            color: kPrimaryColor2,
                          )),
                        ),
                      ),
                      SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor: mainPrimaryColor,
                        radius: 30,
                        child: Center(
                            child: Icon(
                          LineIcons.dollarSign,
                          color: kPrimaryColor2,
                        )),
                      ),
                      SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor: mainPrimaryColor,
                        radius: 30,
                        child: Center(
                          child: Center(
                              child: Icon(
                            LineIcons.moneyCheck,
                            color: kPrimaryColor2,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Payment Amount",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: "Enter amount",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF1A1A1A).withOpacity(0.2494),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color(0xFF1A1A1A).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Payment Note",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    minLines: 8,
                    maxLines: 8,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: "Add payment note",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF1A1A1A).withOpacity(0.2494),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color(0xFF1A1A1A).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 81,
        width: 375,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              // _showConfirmationDialog(context)
              saveDestination();
            },
            child: Container(
              height: 49,
              width: 345,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 21,
                    height: 21,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        LineIcons.paperPlane,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text("Book Trip",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 430,
          width: 327,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const SizedBox(
                  width: 180,
                  height: 180,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(LineIcons.checkCircleAlt),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  "The trip has been booked successfully!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextButton(
                  child: const Text("Ok, Thanks"),
                  onPressed: () {
                Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
