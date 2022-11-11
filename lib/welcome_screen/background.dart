import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/components/constants.dart';
import 'package:my_zupco/log_in/log_in.dart';
import 'package:my_zupco/sign_up/sign_up.dart';
import 'package:my_zupco/welcome_screen/welcome_screen.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              LineIcons.arrowLeft,
              color: kPrimaryColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const WelcomeScreen();
                  },
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  // Customization of widget
                  radius: const Radius.circular(3),
                  backgroundColor: Colors.grey.shade300,
                  indicatorColor: kPrimaryColor2,
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,
                  height: 45,
                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: const [
                    SegmentTab(
                      label: 'Log In',
                    ),
                    // For example, this overrides [indicatorColor] from [SegmentedTabControl]

                    SegmentTab(
                      label: 'Sign Up',
                    )
                  ],
                ),
              ),
              // Sample pages
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    LoginPage(),
                    SignUpPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
