import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';
import 'package:realestate/services/ads_firestore_service.dart';

class PostComplaint extends StatefulWidget {
  @override
  _PostComplaintState createState() => _PostComplaintState();
}

class _PostComplaintState extends State<PostComplaint> {
  @override
  Widget build(BuildContext context) {
    return PostComplaintInfo();
  }
}

class PostComplaintInfo extends StatefulWidget {
  final String complaintTitle;
  final String complaintDescription;

  PostComplaintInfo({this.complaintTitle, this.complaintDescription});

  @override
  _PostComplaintInfoState createState() => _PostComplaintInfoState();
}

class _PostComplaintInfoState extends State<PostComplaintInfo> {
  bool loading = false;

  //text field state
  String title;
  String desc;
  String priority ;
  File _imageFile;

  final _formKey = GlobalKey<FormState>();
  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }


  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[600],
          centerTitle: true,
          title: Column(children: [
            Text(
              "New Complaint",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ]),
        ),
        body: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: false,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[

                  Text("Enter Complaint Title"), SizedBox( height:5),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.title,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Ad Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                    (val.length <= 5 || val.length >= 18)
                        ? 'Title should range within 5 to 18 letters.'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Enter Complaint Description"), SizedBox( height:5),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.description,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Enter your description",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                    (val.length <= 10 || val.length >= 180)
                        ? '*Description should range within 10 to 180 letters.'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        desc = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Text("Priority"), SizedBox(height: 5,),
                  DropdownButtonFormField<String>(
                    value: priority,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:
                        Colors.grey),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:
                        Colors.grey),
                      ),
                    ),
                    isDense: true,
                    hint: Text('Set complaint priority'),
                    style: TextStyle(color: Colors.black),


                    onChanged: (String newValue) {
                      setState(() {
                        priority = newValue;
                      }
                      );
                    },

                    items: <String>['High','Low']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value)=>value==null?'please specify Priority':null,

                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.photo_camera),
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text("Take Photo"),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),


                  RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text("Submit Complaint"),
                      onPressed: () async{
                        if (_formKey.currentState.validate()) {


                        }
                      }

                  ),
                ],
              ),
            )));
  }
}
