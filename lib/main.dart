import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/ads/images_from_firebase_storage.dart';
import 'package:realestate/screens/ads/non_CommercialAd.dart';
import 'package:realestate/screens/authenticate/welcome_screen.dart';
import 'package:realestate/screens/wrapper.dart';
import 'package:realestate/services/auth.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
