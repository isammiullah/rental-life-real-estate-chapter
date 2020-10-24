import 'package:flutter/material.dart';
import 'package:realestate/model/userInfo.dart';

class UserInfoTile extends StatelessWidget {
  final UserData userData;

  UserInfoTile({this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
          ),
          title: Text(userData.email),
          subtitle: Text('First Name: ${userData.firstName}, Last Name: ${userData.lastName} & Age: ${userData.age}'),
        ),
      ),
    );
  }
}
