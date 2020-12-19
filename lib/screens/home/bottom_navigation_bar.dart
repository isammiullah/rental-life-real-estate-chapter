import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/comm_Ad.dart';
import 'package:realestate/model/nonComm_Ad.dart';
import 'package:realestate/screens/Chat/ChatScreen.dart';
import 'package:realestate/screens/Chat/ChatUI.dart';
import 'package:realestate/screens/NewsFeed/AdsFeed.dart';
import 'package:realestate/screens/NewsFeed/NewsFeed.dart';
import 'package:realestate/screens/ads/CommercialTabBar.dart';
import 'package:realestate/screens/ads/NonCommDescriptionLocation.dart';
import 'package:realestate/screens/ads/commercialAd.dart';
import 'package:realestate/screens/ads/complaintScreen.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/ads/nonCommercialTabBar.dart';
import 'package:realestate/screens/ads/non_CommercialAd.dart';
import 'package:realestate/screens/ads/post_Ad_Screen.dart';
import 'package:realestate/screens/ads/user_ads_main_page.dart';
import 'package:realestate/screens/home/home.dart';
import 'package:realestate/screens/home/user_profile.dart';

class BottomNavigationWidget extends StatefulWidget {
  BottomNavigationWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    /*Text(
      'Index 0: Home',
      style: optionStyle,
    ),*/
    Home(),
    PostComplaint(), //PostAd(), //ImageCapture(),
    CommercialTabBar(),
    //nonCommAdSecondStep(),
    //non_CommercialAd(),
    nonCommercialTabBar(),
    NewsFeed(),
    AdsFeed(),
    ChatUi(),
    ProfilePage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

       Provider<commAd>(
         create: (_)=> commAd(),
         child: Provider<nonCommAd>(
           create: (_)=> nonCommAd(),
           child: Center(
             child: _widgetOptions.elementAt(_selectedIndex),
           ),
         ),
       ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance),
            title: Text('Complaint'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text('Commercial Ads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('NonCommercial Ads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_inner),
            title: Text('Ads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(
              'Account',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}
