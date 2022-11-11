import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:my_zupco/models/RouteDetailsModel.dart';

import '../../../components/constants.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<RouteDetailsModel> taxi;

  const ChatHeaderWidget({
    required this.taxi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: altPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taxi.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const CircleAvatar(
                        backgroundColor: kPrimaryColor2,
                        radius: 24,
                        child: Icon(
                          LineIcons.busAlt,
                          color: altPrimaryColor,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: taxi[index]),
                          ));*/
                        },
                        child: const CircleAvatar(
                          backgroundColor: kPrimaryColor2,
                          radius: 24,
                          child: Icon(
                            LineIcons.busAlt,
                            color: altPrimaryColor,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}
