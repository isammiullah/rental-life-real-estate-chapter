import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/AdInfo.dart';
import 'package:realestate/model/userInfo.dart';
import 'package:realestate/screens/home/adInfo_tile.dart';
import 'package:realestate/screens/home/userInfo_tile.dart';

class AdsInfoList extends StatefulWidget {
  @override
  _AdsInfoListState createState() => _AdsInfoListState();
}

class _AdsInfoListState extends State<AdsInfoList> {
  @override
  Widget build(BuildContext context) {
    final adInfo = Provider.of<List<AdData>>(context) ?? [];


    //here the filter will be implemented

    return ListView.builder(
      itemCount: adInfo.length,
      itemBuilder: (context, index) {
        return AdInfoTile(adData: adInfo[index]);
      },
    );
  }
}
