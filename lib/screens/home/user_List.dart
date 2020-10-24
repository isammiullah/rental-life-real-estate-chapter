import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/userInfo.dart';
import 'package:realestate/screens/home/userInfo_tile.dart';

class UserInfoList extends StatefulWidget {
  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserData>>(context) ?? [];

    return ListView.builder(
      itemCount: userInfo.length,
      itemBuilder: (context, index) {
        return UserInfoTile(userData: userInfo[index]);
      },
    );
  }
}
