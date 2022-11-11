import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:my_zupco/pages/details.dart';
import 'package:my_zupco/pages/schedule.dart';

import '../components/constants.dart';
import '../log_in/settings.dart';
import '../models/UserModel.dart';

import 'home.dart';


class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}
@override
void initState() {
  getCurrentLocation();
  //super.initState();
}

late LocationData currentLocation;

void getCurrentLocation() async {
  Location location = Location();

  location.getLocation().then(

        (location) {
      currentLocation = location;
    },


  );

  if (kDebugMode) {
    print("longitude+${currentLocation.longitude}");
  }
  if (kDebugMode) {
    print(currentLocation.latitude);
  }


}
class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
   List<Widget> screens = [
     const Home(),
     const Schedule(),
     const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(LineIcons.bars, color: kPrimaryColor2,),
        actions:  [
          Padding(padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            child:  const SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                LineIcons.userCog,
                size: 30,
                color: mainPrimaryColor,
              ),
            ),
            onTap:   () {
        
                },
          ),)

        ],
        elevation: 0,

      ),
      body: screens[currentIndex],

        bottomNavigationBar: Container(
          
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40),top: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
              
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: GNav(
                      rippleColor: Colors.grey[300]!,
                      hoverColor: kPrimaryColor2,

                      gap: 8,
                      activeColor: kPrimaryColor,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.white,
                      color: Colors.black38,
                      tabs:   const [
                        GButton(
                          icon: LineIcons.home,
                          text: 'Home',
                          iconActiveColor: altPrimaryColor,
                          backgroundColor: kPrimaryColor2,
                          textColor: altPrimaryColor,

                        ),

                        GButton(
                          icon: LineIcons.clipboard,
                          iconActiveColor: altPrimaryColor,
                          backgroundColor: kPrimaryColor2,
                          text: 'Schedule',
                          textColor: altPrimaryColor,


                        ),

                        GButton(
                          icon: LineIcons.user,
                          text: 'User',
                          iconActiveColor: altPrimaryColor,
                          backgroundColor: kPrimaryColor2,
                          textColor: altPrimaryColor,

                        ),

                      ],
                      selectedIndex: currentIndex,
                      onTabChange: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    )
                )
            )
        )

    );
  }
  }

Route createRoute(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const  ProfilePage(),
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

Route createRoute1(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const  RouteDetails(),
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
