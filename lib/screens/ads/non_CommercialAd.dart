import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:realestate/model/nonComm_Ad.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:realestate/screens/ads/set_Location.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:search_map_place/search_map_place.dart';




class non_CommercialAd extends StatefulWidget {
  @override
  //UserAd userAd;
 // non_CommercialAd({Key key, @required this.userAd}): super(key: key);

  _non_CommercialAdState createState() => _non_CommercialAdState();
}


class _non_CommercialAdState extends State<non_CommercialAd> {
  @override
  Widget build(BuildContext context) {
    return PostAdInfo();
  }
}





class PostAdInfo extends StatefulWidget {
  final String adTitle;
  final String adDescription;


  PostAdInfo({this.adTitle, this.adDescription});

  @override
  _PostAdInfoState createState() => _PostAdInfoState();
}

class _PostAdInfoState extends State<PostAdInfo> {
  bool loading = false;

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
  //text field state
  String title = '';
  String beds = '';
  String bath = '';
  String floor = '';
  String size = '';
  LatLng latlngVar= LatLng(0,0);
  String rent = '';
  String desc = '';
  String error = '';
  String floorValue= '';
  String dropdownValue = '';
  String type= "";

  nonCommAd newAd = nonCommAd();
  //final UserAd newAd = UserAd();
  //newAd.title= "boom";
  final db= Firestore.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var userPosition;



    return Scaffold(
        appBar: new AppBar(
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
                "Ad Info",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 17,
                ),
              ),
            )
          ]),
        ),
       // backgroundColor: Colors.white70,
        body: Container(

            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
             // color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
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
                        newAd.title= val;
                        title=val;
                        //email = val;
                      });
                    },
                  ),
                  SizedBox(height: 10,),


                  Row(

                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //width: 80,
                          child: TextFormField(
                            decoration: InputDecoration(

                              hintText: "Beds (e.g. 2)",
                              border: OutlineInputBorder(),
                            ),
                            validator: ((val) =>
                            (val.length < 1)
                                ? 'Enter a valid number.'
                                : null),
                            onChanged: (val) {
                              setState(() {
                                newAd.beds=val;
                                beds= val;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(width: 20,),


                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //width: 80,
                          child: TextFormField(
                            decoration: InputDecoration(

                              hintText: "Bathrooms (e.g. 1)",
                              border: OutlineInputBorder(),
                            ),
                            validator: ((val) =>
                            (val.length < 1)
                                ? 'Enter a Valid Number'
                                : null),
                            onChanged: (val) {
                              setState(() {
                                newAd.bath= val;
                                bath= val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 10,),

                  Row(

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text("Floor:",
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                        ),
                      ),



                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              //color: Colors.blueGrey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(5)),

                            ),
                            child: DropdownButton<String>(
                              value: floor,
                              icon: Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,
                              autofocus: true,

                              hint: Text('Floor'),
                              style: TextStyle(color: Colors.black),

                              underline: Container(
                                height: 10,
                                //  color: Colors.grey[400],
                              ),
                              onChanged: (String newValue) {
                                //newAd.floor= newValue;
                                setState(() {
                                  newAd.floor= newValue;
                                  floor = newValue;
                                }
                                );
                              },

                              items: <String>['','Ground Floor ',' Basement ',' 1st Floor', ' 2nd Floor ', ' 3rd Floor' ,' 4th FLoor ',' 5th Floor']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20,),

                      Text("Size:",
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                      ),

                      SizedBox(width: 10,),


                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              //color: Colors.blueGrey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(5)),

                            ),
                            child: DropdownButton<String>(
                              value: size,

                              icon: Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,

                              hint: Text('Size'),
                              style: TextStyle(color: Colors.black),

                              underline: Container(
                                height: 10,
                                //  color: Colors.grey[400],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  newAd.size = newValue;
                                  size = newValue;
                                }
                                );
                              },

                              items: <String>['',' 3 Marla',' 5 Marla',' 7 Marla',' 10 Marla', ' 1 kanal', ' 2 kanal']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text("Type: ",
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                        ),
                      ),


                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              //color: Colors.blueGrey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(5)),

                            ),
                            child: DropdownButton<String>(
                              value: type,

                              icon: Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,

                              hint: Text('Type'),
                              style: TextStyle(color: Colors.black),

                              underline: Container(
                                height: 10,
                                //  color: Colors.grey[400],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  newAd.type= newValue;
                                  type = newValue;
                                }
                                );
                              },

                              items: <String>['', ' House ',' Flat ']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width:20),

                      Container(
                      //  padding: EdgeInsets.all(2),
                        child: Text("Rent:",
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                        ),
                      ),

                      SizedBox(width:10),

                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //width: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.attach_money,
                                color: Colors.blueGrey,
                              ),
                              hintText: "(e.g. 10000)",
                              border: OutlineInputBorder(),
                            ),
                            validator: ((val) =>
                            (val.length < 1)
                                ? 'Enter a Valid Number'
                                : null),
                            onChanged: (val) {
                              setState(() {
                                newAd.rent= val;
                                rent = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),


                  TextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.description,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Ad Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                    (val.length <= 10 || val.length >= 180)
                        ? '*Description should range within 10 to 180 letters.'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        newAd.desc=val;
                        desc= val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SearchMapPlaceWidget(
                    apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',

                    // The language of the autocompletion
                    //icon: Icons.add_location,
                    language: 'en',
                    // The position used to give better recomendations. In this case we are using the user position
                   // location: userPosition.coordinates,
                   // radius: 30000,
                    darkMode: true,

                    onSelected: (Place place) async {


                      try{
                        final geolocation = await place.geolocation;
                        //newAd.location = geolocation;
                     //   newAd.location = geolocation.coordinates;



                      }catch(e){
                        print(e);
                      }


                      /*
                      final geolocation = await place.geolocation;

                      latlngVar = geolocation.coordinates;
                      newAd.location = latlngVar;
                      print(newAd.location);
                      */
                    }
                  ),

                  SizedBox(
                    height: 10,
                  ),

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
                   //   maintainSize: true,
                    //  maintainAnimation: true,
                   //   maintainState: true,
                      visible: widgetVisible,
                      child: SizedBox(
                          height: 300,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                  color: Colors.redAccent,
                              )
                              ),
                              child: LocationWidget(),



                          )
                      ),
                  ),
  /*                SizedBox(
                    height: 20,
                  ),

                  RaisedButton(
                    color: Colors.yellow,
                    onPressed: (){showDialog(
                      context: context,
                    builder:(BuildContext context)=> FancyDialog(
                      title: "Fancy Gif Dialog",
                      descreption: "",

                     )
                    );
                    },
                  ),
*/

    /*              RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text("Set Location"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget()),
                          );*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCapture()),
                          );
                        }
                      }

                  ),

*/

                  SizedBox(
                    //height: 10,
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


                        newAd.category= 'Non Commercial';
                        if (_formKey.currentState.validate()) {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget()),
                          );*/


                          await db.collection("Ads").add(newAd.toJson());

                       // Uploader
                         /*

                          await db.collection("User").document("Ads").collection("Ad info").add({

                          'category': "Commercial",
                          'type' : type,
                          'title': title,
                          'beds' : beds,
                          'bath' : bath,
                          'floor': floor,
                          'size' : size,
                          'rent' : rent,
                          'desc' : desc,
                          //'error' ="";

                          });

                          */

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCapture(userAd: newAd)),
                          );
                        }
                      }

                  ),
                ],
              ),
            )));
  }

}
