import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_zupco/components/constants.dart';

class RecentTransactionsPage extends StatelessWidget {
  const RecentTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecentTransactionsView();
  }
}

class RecentTransactionsView extends StatefulWidget {
  const RecentTransactionsView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecentTransactionsViewState createState() => _RecentTransactionsViewState();
}

class _RecentTransactionsViewState extends State<RecentTransactionsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: altPrimaryColor,
          leading: IconButton(
            icon: const Icon(
              LineIcons.arrowLeft,
              color: kPrimaryColor2,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Your Payments",
              style: GoogleFonts.poppins(color: kPrimaryColor2)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {},
              color: kPrimaryColor,
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Your Balance",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "ZWL\$ 3000.60",
                      style: TextStyle(
                        fontSize: 34,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: FractionalOffset.center,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: 40,
                              ),
                              Text('DEPOSIT CASH',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "PAYMENT SCHEDULED: 9/24",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(26),
              width: double.infinity,
              color: Colors.black12,
              child: const Text(
                "Recent Trips",
                style: TextStyle(fontSize: 20, color: Colors.black38),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Harare",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "ZWL\$ 350.00",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Sep 19, 10:30 AM",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "ZWL\$ 350.00",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Chitungwiza",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ZWL\$ 800.00",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Sep 21, 5:13 PM",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "ZWL\$ 800.00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Budiriro",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ZWL\$ 350.00",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Sep 25, 08:13 AM",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "ZWL\$ 350.00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
