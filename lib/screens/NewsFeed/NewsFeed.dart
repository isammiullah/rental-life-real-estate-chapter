/*
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/screens/home/settings_form.dart';
import 'package:realestate/screens/home/user_List.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/services/database.dart';
import 'package:realestate/model/userInfo.dart';

class NewsFeed extends StatelessWidget {
  AuthService _authService = AuthService();
  //FirebaseStorage storage = FirebaseStorage.instance;
  */
/*StorageReference imgRef = FirebaseStorage.instance.ref().child("Ads")
      .child("0scYYedu6bRacB5JW2L8ELxiEaj2")
      .child("Image1.png");*//*

  //var url = await ref.getDownloadURL();
  String _downloadUrl;
  var url = '';
  Future downloadImage() async {
    StorageReference imgRef = FirebaseStorage.instance.ref().child("Ads")
        .child("0scYYedu6bRacB5JW2L8ELxiEaj2")
        .child("Image1.png");
    var url = await imgRef.getDownloadURL();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.red[600],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () => downloadImage(),
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
            FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings')),
          ],
        ),

        body: Image.network(
          url,
        ),
      );
  }
}
*/

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  var url = '';
  var uid = '';

  Future downloadImage() async {
    StorageReference imgRef = FirebaseStorage.instance.ref().child("Ads")
        .child(uid)
        .child("Image1.png");
    url = await imgRef.getDownloadURL();

    setState(() {
      print("URL IS : $url");
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    uid = user.uid;
    print("In build method: URL is $url");
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('My Ads'),
        backgroundColor: Colors.red[600],
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => downloadImage(),
              icon: Icon(Icons.image),
              label: Text('View Ad Image')),
        ],
      ),

      body: Image.network(
        url,
      ),
    );
  }
}
