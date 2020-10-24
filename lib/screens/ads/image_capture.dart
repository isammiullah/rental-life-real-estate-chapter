import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realestate/model/nonComm_Ad.dart';
import 'package:realestate/screens/ads/non_CommercialAd.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';

/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  nonCommAd userAd;
  ImageCapture({Key key, @required this.userAd}): super(key: key);
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        //toolbarColor: Colors.purple,
        //toolbarWidgetColor: Colors.white,
        //toolbarTitle: 'Crop It'
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Column(children: [
          Text(
            "Post an Ad",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          Text(
            "Upload an Image",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 17,
            ),
          ),
        ]),
      ),
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.photo_camera),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              label: Text("Capture"),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(width: 20,),
            RaisedButton.icon(
              icon: Icon(Icons.photo_library),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              label: Text("Gallery"),
                onPressed: () => _pickImage(ImageSource.gallery),
            ),
            /*IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),*/
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),

            Uploader(file: _imageFile)
          ]
        ],
      ),
    );
  }
}

class _UploaderState extends State<Uploader> {
  nonCommAd userAd = nonCommAd();
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://rent-alife.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    String filePath = 'Ads_Images/${DateTime.now()}.png';


    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete)Text('🎉 Ad Posted Successfully 🎉'),
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("Back"),
                    onPressed: ()  {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture(userAd: userAd)),
                      );
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => non_CommercialAd()),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationWidget()),
                      );
                    },
                  ),


                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return
        RaisedButton.icon(
          icon: Icon(Icons.cloud_upload),
          color: Colors.red,
          textColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          label: Text('Upload Ad'),
          onPressed:() async{
            // await db.collection("Ad").add(userAd.toJson());
            _startUpload();},
        );

        /*FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );*/
    }
  }
}

/// Widget used to handle the management of
class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}
