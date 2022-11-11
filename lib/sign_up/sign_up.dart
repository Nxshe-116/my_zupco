
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_zupco/inspector_pages/inspector_home.dart';

import '../components/constants.dart';
import '../components/error.dart';
import '../drivers_pages/homedriver/home_driver.dart';
import '../log_in/log_in.dart';
import '../models/UIHelper.dart';
import '../models/UserModel.dart';

import '../pages/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  _SignUpPageState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  var options = [
    'Driver',
    'Passenger',
    'Inspector'
  ];
  var _currentItemSelected = "Passenger";
  var roll = "Passenger";
  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = confirmpassController.text.trim();

    if(email == "" || password == "" || cPassword == "") {
      UIHelper.showAlertDialog(context, "Incomplete Data", "Please fill all the fields",);
    }
    else if(password != cPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch", "The passwords you entered do not match!");
    }
    else {
      signUp(email, password,roll);
    }
  }

  void signUp(String email, String password, String rool) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(context, "An error occurred", ex.message.toString(),);
    }

    if(credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
          uid: uid,
          email: email,
         role: rool
      );
      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value) {
        if (kDebugMode) {
          print("New User Created!");
        }
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) {
                
                if (newUser.role == "Passenger") {
            return HomePage(
                userModel: newUser, firebaseUser: credential!.user!);
          } else if (newUser.role == "Driver") {
            return DriverHomePage(
                userModel: newUser, firebaseUser: credential!.user!);
          }
          else if (newUser.role == "Inspector") {
            return InspectorHomePage(
                userModel: newUser, firebaseUser: credential!.user!);
          }
          return const ErrorPage();


              }
          ),
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:altPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: altPrimaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      const SizedBox(
                          height: 35,
                        ),

                        TextFormField(
                            autofocus: false,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              RegExp regex =  RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Email",
                              hintStyle:  GoogleFonts.poppins( color: Colors.grey),
                              focusedBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                              ),
                              enabledBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:  const BorderSide(color: kPrimaryColor2, width: 15.0),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),


                          onChanged: (value) {}
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(

                          autofocus: false,

                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp regex =  RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                            return null;
                          },
                          obscureText: _isObscure,
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Password",
                            hintStyle:  GoogleFonts.poppins( color: Colors.grey),
                            focusedBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                            ),
                            enabledBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide:  const BorderSide(color: kPrimaryColor2, width: 15.0),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),

                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(

                          autofocus: false,


                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Confirm Password",
                            hintStyle:  GoogleFonts.poppins( color: Colors.grey),
                            focusedBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                            ),
                            enabledBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor2, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide:  const BorderSide(color: kPrimaryColor2, width: 15.0),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              "Role : ",
                              style:  GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: mainPrimaryColor,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: altPrimaryColor,
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.white,
                              focusColor: Colors.white,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style:  GoogleFonts.poppins(
                                      color: kPrimaryColor2,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  roll = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(

                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor2,
                            child: MaterialButton(
                                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  setState(() {
                                    showProgress = true;
                                  });
                                  signUp(emailController.text,
                                      passwordController.text, roll);
                                },
                                child:  const Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: altPrimaryColor, fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.role = rool;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}