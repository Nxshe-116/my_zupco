import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/constants.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor2,
          elevation: 0,
          title: Text(
            "Error",
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
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/Error.gif",
                    height: 500,
                    width: 500,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text("Error! Contact the Administrator",
                      style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 30))
                ])));
  }
}
