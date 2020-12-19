import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/comm_Ad.dart';
import 'package:realestate/model/nonComm_Ad.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';
import 'package:realestate/screens/ads/set_Location.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:search_map_place/search_map_place.dart';

class CommAdSecondStep extends StatefulWidget {
  @override
  _CommAdSecondStepState createState() => _CommAdSecondStepState();
}

class _CommAdSecondStepState extends State<CommAdSecondStep> {
  @override
  Widget build(BuildContexext) {
    return locationDescription();
  }
}

class locationDescription extends StatefulWidget {
  @override
  _locationDescriptionState createState() => _locationDescriptionState();
}

class _locationDescriptionState extends State<locationDescription> {
  bool loading = false;
  Position currentPosition= Position();

  LatLng _selectedPosition;
  double _distance;
  String _currentAddress="";
  String city;
  String _lat= "";
  String _lng = "";
  Position initialPosition;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  GoogleMapController mapController;
  LatLng selectedLocation = LatLng(33.6844, 73.0479);

  Set<Marker> _markers = Set<Marker>();


  bool widgetVisible = false ;

  void showWidget(){
    setState(() {
      widgetVisible = !widgetVisible ;
    });
  }

  void hideWidget(){
    setState(() {
      widgetVisible = false ;
    });
  }

  void getUserLocation(Position sel){

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        initialPosition = position;

      });
      // _getAddressFromLatLng(_currentPosition);

    }).catchError((e) {
      print(e);
    });

  }

  Future getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> places = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = places[0];
      setState(() {
        return  city = place.locality;
      });
    } catch (e) {
      print(e);
    }
  }


  final _formKey = GlobalKey<FormState>();
  final db= Firestore.instance;
  Widget build(BuildContext context) {
    final newAd = Provider.of<commAd>(context);
    //getUserLocation(selectedLocation);


    return Scaffold(
      /*    appBar: new AppBar(
        backgroundColor: Colors.red[500],
        centerTitle: true,
        title: Column(children: [
          Text(
            "Create Ad",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          GestureDetector(
            child: Text(
              "Step 2/3",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 17,
              ),
            ),
          )
        ]),
      ),
*/
      body: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),

        child:Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.description,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Ad Description",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) =>
                (val.length <= 10 || val.length >= 200)
                    ? '*Description should range within 10 to 180 letters.'
                    : null),
                onChanged: (val) {
                  setState(() {
                    newAd.desc=val;

                  });
                },
              ),
              SizedBox(
                height: 10,
              ),

              SearchMapPlaceWidget(
                  apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',
                  placeholder: "Search Location",

                  language: 'en',
                  darkMode: true,
                  onSelected: (Place place) async {

                    try{
                      final geolocation = await place.geolocation;
                      newAd.location = geolocation as LatLng;

                    }catch(e){
                      print(e);
                    }
                  }
              ),

              SizedBox(
                height: 10,
              ),

              Center(child: Text("OR",)),
              RaisedButton(
                onPressed: showWidget,

                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text("Select Location On Map"),

              ),

              SizedBox(
                height: 10,
              ),

              Visibility(

                visible: widgetVisible,
                child: SizedBox(
                    height: 400,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.redAccent,
                          )
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            SearchMapPlaceWidget(
                                hasClearButton: true,
                                placeType: PlaceType.address,
                                placeholder: 'Enter the location',
                                apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',

                                onSelected: (Place place) async {

                                  Geolocation geolocation = await place.geolocation;
                                  mapController.animateCamera(
                                      CameraUpdate.newLatLng(geolocation.coordinates));
                                  mapController.animateCamera(
                                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                                  selectedLocation= geolocation.coordinates;

                                  _markers.clear();
                                  final marker = Marker(
                                    markerId: MarkerId("Marker"),
                                    position: LatLng(selectedLocation.latitude, selectedLocation.longitude),
                                    // infoWindow: InfoWindow(title: currentAddress),
                                  );
                                  _markers.add(marker);

                                  List<Placemark> placemarks = await Geolocator()
                                      .placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
                                  if (placemarks != null && placemarks.isNotEmpty) {
                                    final Placemark pos = placemarks[0];

                                    newAd.city= pos.locality;
                                    newAd.location=selectedLocation;
                                  }

                                  setState(() {

                                    //  print(selectedLocation);
                                    newAd.location = selectedLocation;
                                  }
                                  );
                                }
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top:15.0),
                                child: SizedBox(
                                  height: 400.0,
                                  child: GoogleMap(
                                    onMapCreated: (GoogleMapController googleMapController) {
                                      setState(() {
                                        mapController = googleMapController;
                                      });

                                    },
                                    initialCameraPosition: CameraPosition(
                                        zoom: 15.0,
                                        target:  LatLng(selectedLocation.latitude, selectedLocation.longitude)
                                    ),
                                    mapType: MapType.satellite,
                                    markers:
                                    Set<Marker>.of (
                                        <Marker>[
                                          Marker(
                                              onTap: () {
                                                print('Tapped');
                                              },
                                              draggable: true,
                                              markerId: MarkerId('Marker'),
                                              position: LatLng(selectedLocation.latitude, selectedLocation.longitude),
                                              onDragEnd: ((newPosition) {
                                                newAd.location= newPosition ;
                                                selectedLocation= newPosition;
                                                print(newPosition.latitude);
                                                print(newPosition.longitude);
                                                setState(() {

                                                });
                                              }))
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),


                    )
                ),
              ),

              RaisedButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text("Next"),
                  onPressed: () async {



                    // newAd.category= 'Non Commercial';
                    if (_formKey.currentState.validate()) {
                      // await db.collection("Ads").add(newAd.toJson());


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture()),
                      );
                    }

                  }

              )


            ],
          ),
        ),
      ),

    );
  }
}


