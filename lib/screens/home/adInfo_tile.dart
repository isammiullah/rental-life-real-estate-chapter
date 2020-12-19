/*
import 'package:flutter/material.dart';
import 'package:realestate/model/AdInfo.dart';
import 'package:realestate/model/userInfo.dart';

class AdInfoTile extends StatelessWidget {
  final AdData adData;

  AdInfoTile({this.adData});

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

          title: Text(adData.title),
          subtitle: Text('Description: ${adData.description} \nImage'),
        ),
      ),
    );
  }
}
*/

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:realestate/model/AdInfo.dart';

class AdInfoTile extends StatefulWidget {
  final AdData adData;

  AdInfoTile({this.adData});

  @override
  _AdInfoTileState createState() => _AdInfoTileState();
}

class _AdInfoTileState extends State<AdInfoTile> {
  var url = '';

  Future loadImage() async {
    StorageReference imgRef = FirebaseStorage.instance
        .ref()
        .child("Ads")
        .child(widget.adData.uid)
        .child("Image1.png");

    url = await imgRef.getDownloadURL();

    setState(() {
      print(url);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Title: ",
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  ),
                  Text(
                    widget.adData.title,
                    style: TextStyle(fontSize: 21, color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Description: ",
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  ),
                  Expanded(
                    child: Text(
                      widget.adData.description,
                      style: TextStyle(fontSize: 21, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              if (url != '')
                Image.network(
                  url,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,

                ),
            ],
          )
          /*ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
              ),
              title: Text(widget.adData.title),
              subtitle: Text(
                  'Description: ${widget.adData.description},\nImage:\n'),

            ),
          ),*/

          /*if(url != '')
          Image.network(url,
          width: 200,
          height: 200,),*/
          //),
          ),
    );
  }
}
/*
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
              ),
              title: Text(widget.adData.title),
              subtitle: Text('Description: ${widget.adData.description},\nImage:\n'),

            ),
          ),
          Image.network(url),
        ],
      ),
    );
  }
}
*/
//}
