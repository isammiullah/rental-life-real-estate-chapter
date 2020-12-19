import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/authenticate/authenticate.dart';
import 'package:realestate/screens/home/home.dart';

import 'authenticate/welcome_screen.dart';
import 'home/bottom_navigation_bar.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget _widget;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      //_widget =  Authenticate();
      _widget =  AuthenticationPage();
    }else{
      _widget =  BottomNavigationWidget();//Home();
    }
    return _widget;
  }
}
