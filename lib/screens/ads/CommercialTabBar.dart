import 'package:flutter/material.dart';
import 'package:realestate/screens/ads/NonCommDescriptionLocation.dart';

import 'CommercialDescriptionLocation.dart';
import 'commercialAd.dart';
import 'image_capture.dart';
import 'non_CommercialAd.dart';


class CommercialTabBar extends StatefulWidget {
  @override
  _CommercialTabBarState createState() => _CommercialTabBarState();

}

class _CommercialTabBarState extends State<CommercialTabBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red[600],
              title: Text("Create Ad"),
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.description), text: "Details"),
                Tab(icon: Icon(Icons.location_on), text: "Description & Location",),
                Tab(icon: Icon(Icons.image), text: "Images",),
              ]
              ),
            ),
            body: TabBarView(children: [
              commercialAd(),
              CommAdSecondStep(),
              ImageCapture(),

            ]),
          ),
        )

    );
  }
}
