



/*
}import '../drivers_pages/homedriver/home_driver.dart';
import 'main_page.dart';

User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();
var roll;
var email;
var id;
@override
void initState() {
  super.initState();
  FirebaseFirestore.instance
      .collection("users") //.where('uid', isEqualTo: user!.uid)
      .doc(user!.uid)
      .get()
      .then((value) {
    this.loggedInUser = UserModel.fromMap(value.data());
  }).whenComplete(() {
    CircularProgressIndicator();
    setState(() {
      email = loggedInUser.email.toString();
      roll = loggedInUser.roll.toString();
      id = loggedInUser.uid.toString();
    });
  });
}

routing() {
  if (roll == 'Student') {
    return HomePage(userModel: newUser, firebaseUser: credential!.user! );
  } else {
    return DriverHomePage(userModel: newUser, firebaseUser: credential!.user! );
  }
}

@override
Widget build(BuildContext context) {
  CircularProgressIndicator();
  return routing();
}
*/
