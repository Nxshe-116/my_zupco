import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/welcome_screen/background.dart';

import '../components/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Image.asset(
              "assets/bg1.png",
              fit: BoxFit.cover,
              height: size.height * 0.85,
              width: size.width,
            ),
          ),
          Center(
            child: SizedBox(
              width: size.width * 0.40,
              height: 60,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute());
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: kPrimaryColor2, width: 2)))),
                child: Row(
                  children: [
                    Text("Get Started",
                        style: GoogleFonts.poppins(
                            color: kPrimaryColor2,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: size.width * 0.008,
                    ),
                    const Icon(LineIcons.arrowRight)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height * 0.85;

    final path = Path();

    //Point<double> topLeft = const Point(0, 0);
    Point<double> topRight = Point(width, 0);
    Point<double> anchor1 = Point(width / 4, height - 90);
    Point<double> anchor2 = Point(width * 0.75, height + 50);
    Point<double> anchor3 = Point(width, height);
    Point<double> bottomLeft = Point(0, height);
    Point<double> bottomRight = Point(width, height);
    Point<double> bottomMid = Point(width / 2, height - 20);

    path.lineTo(bottomLeft.x, bottomLeft.y);
    path.quadraticBezierTo(anchor1.x, anchor1.y, bottomMid.x, bottomMid.y);
    path.cubicTo(anchor2.x, anchor2.y, anchor3.x, anchor3.y, bottomRight.x,
        bottomRight.y);
    path.lineTo(topRight.x, topRight.y);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Background(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
