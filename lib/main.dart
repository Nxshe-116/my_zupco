import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_zupco/components/error.dart';
import 'package:my_zupco/inspector_pages/inspector_home.dart';

import 'package:my_zupco/pages/main_page.dart';
import 'package:my_zupco/welcome_screen/welcome_screen.dart';

import 'package:uuid/uuid.dart';

import 'models/FirebaseHelper.dart';
import 'models/UserModel.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Logged In
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      if (thisUserModel.role == "Passenger") {
        runApp(MyPassengerLoggedIn(
            userModel: thisUserModel, firebaseUser: currentUser));
      } else if (thisUserModel.role == "Driver") {
        runApp(InspectorLoggedIn(
            userModel: thisUserModel, firebaseUser: currentUser));
      } else if (thisUserModel.role == "Inspector") {
        runApp(InspectorLoggedIn(
            userModel: thisUserModel, firebaseUser: currentUser));
      }
    } else {
      runApp(const ErrorPage());
    }
  } else {
    // Not logged in
    runApp(const MyApp());
  }
}

// Not Logged In
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen())));
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(children: [
          const SizedBox(
            height: 200,
          ),
          Image.asset(
            "assets/logos/mainlogo.png",
            width: size.width * 0.9,
          ),
          SizedBox(height: size.height * 0.1),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/loading.gif",
                  height: 100,
                  width: 100,
                ),
              )),
        ]),
      ),
    );
  }
}

class MyPassengerLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyPassengerLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}

class MyDriverLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyDriverLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}

class InspectorLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const InspectorLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InspectorHomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}
