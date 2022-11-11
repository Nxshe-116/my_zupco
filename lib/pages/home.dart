import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/pages/Settings_pages/trip-booking.dart';

import 'package:my_zupco/pages/map.dart';
import 'package:my_zupco/pages/transactions.dart';
import '../components/constants.dart';
import 'banners.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

@override
void initState() {
  getCurrentLocation();
  //super.initState();
}

late LatLng latitude;
late LatLng longitude;
late LocationData currentLocation;

void getCurrentLocation() async {
  Location location = Location();

  location.getLocation().then(
    (location) {
      currentLocation = location;
    },
  );
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(" Welcome, Passenger",
              style: GoogleFonts.poppins(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 30)),
          const SizedBox(height: 12),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              child: BannerCarousel(
                banners: BannerImages.listBanners,
                customizedIndicators: const IndicatorModel.animation(
                    width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                height: size.height * 0.25,
                activeColor: kPrimaryColor2,
                disableColor: Colors.white,
                animation: true,
                borderRadius: 8,
                width: size.width,
                indicatorBottom: false,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Maps();
                    },
                  ),
                );
              },
              child: Container(
                  height: size.height * 0.15,
                  width: size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          opacity: 80,
                          image: AssetImage("assets/maps/map.png"),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Current Location".toUpperCase(),
                            style: GoogleFonts.lato(
                                color: altPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(height: size.width * 0.05),
                        const Icon(
                          LineIcons.arrowCircleRight,
                          color: altPrimaryColor,
                        )
                      ],
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SafeArea(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TripBooking();
                      },
                    ),
                  );
                },
                child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.45,
                    decoration: const BoxDecoration(
                        color: kPrimaryColor2,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: Text("Intercity booking",
                            style: GoogleFonts.lato(
                                color: altPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)))),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(createRoute());
                  },
                  child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor2,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text("Zupco Payments",
                              style: GoogleFonts.lato(
                                  color: altPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))))),
            ],
          ))
        ],
      )),
    );
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const RecentTransactionsPage(),
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
