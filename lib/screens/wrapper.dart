import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/ads/comercialAd.dart';
import 'package:realestate/screens/authenticate/authenticate.dart';
import 'package:realestate/screens/home/home.dart';
import 'package:realestate/screens/ads/non_CommercialAd.dart';
import 'authenticate/welcome_screen.dart';
import 'home/bottom_navigation_bar.dart';
import 'package:realestate/screens/ads/set_Location.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget _widget;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      //_widget =  Authenticate();
      //_widget= non_CommercialAd();
      _widget= commercialAd();
     // _widget= setLocation();
     // _widget =  AuthenticationPage();
    }else{
     // _widget= setLocation();
     // _widget= non_CommercialAd();
      _widget= commercialAd();
    //  _widget =  BottomNavigationWidget();//Home();
    }
    return _widget;
  }
}
