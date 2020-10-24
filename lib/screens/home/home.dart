import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/screens/home/settings_form.dart';
import 'package:realestate/screens/home/user_List.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/services/database.dart';
import 'package:realestate/model/userInfo.dart';

class Home extends StatelessWidget {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().userDocumentsStream,
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.red[600],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings')),
          ],
        ),
        body: UserInfoList(),
      ),
    );
  }
}
