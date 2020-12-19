import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/comm_Ad.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';
import 'package:realestate/screens/ads/set_Location.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:search_map_place/search_map_place.dart';

import 'CommercialDescriptionLocation.dart';


class commercialAd extends StatefulWidget {
  @override
  _commercialAdState createState() => _commercialAdState();
}


class _commercialAdState extends State<commercialAd> {
  @override
  Widget build(BuildContext context) {
    return Provider<commAd>(
      create: (_)=> commAd(),
        child: PostAdInfo());
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

  bool cateringVisible = false ;

  void showCatering(){
    setState(() {
      cateringVisible = true ;
    });
  }

  void hideCatering(){
    setState(() {
      cateringVisible = false ;
    });
  }


  bool widgetVisible = false ;

  void showWidget(){
    setState(() {
      widgetVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      widgetVisible = false ;
    });
  }
  //text field state
  String title = '';
  String desc = '';
  String error = '';
  int rent;
  String type ;
  double size ;
  String sizeUnit;
  int seatingCapacity;
  String floor;
  String catering ;
  int maxChargesPerPerson ;
  int minChargesPerPerson;
  String floorValue= '';
  String dropdownValue = '';


  final db= Firestore.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final newAd = Provider.of<commAd>(context);
    newAd.category= 'Commercial';

    return Scaffold(
        /*appBar: new AppBar(
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
        */
        //  backgroundColor: Colors.green,
        body: Container(

            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              //color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  /*TextFormField(
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
                        newAd.title=val;
                        //email = val;
                      });
                    },
                  ),
                  */


/*
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //width: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Rooms (e.g. 2)",
                              border: OutlineInputBorder(),
                            ),
                            validator: ((val) =>
                            (val.length < 1)
                                ? 'Enter a valid number.'
                                : null),
                            onChanged: (val) {
                              setState(() {
                                //email = val;
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
                                //email = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
*/

              //    SizedBox(height: 10,),
                  Row(

                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text("Floor:",
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                        ),
                      ),


                      //SizedBox(width:),
                      Expanded(
                        child: DropdownButtonFormField<String>(
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

                          elevation: 2,
                          isDense: true,
                          value: floor,
                          hint: Text('Select Floor'),
                          style: TextStyle(color: Colors.black),

                          onChanged: (String newValue) {
                            //newAd.floor= newValue;
                            setState(() {
                              newAd.floor= newValue;
                              floor = newValue;
                            }
                            );
                          },
                          validator: (value)=>value==null?'Please specify floor':null,

                          items: <String>['','Ground Floor ',' Basement ',' 1st Floor', ' 2nd Floor ', ' 3rd Floor' ,' 4th FLoor ',' 5th Floor']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[

                      Text("Size:",
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                      ),

                      SizedBox(width: 10,),

                      Expanded(
                        child: DropdownButtonFormField<double>(
                          value: size,
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
                          hint: Text('Plot Size'),
                          style: TextStyle(color: Colors.black),


                          onChanged: (double newValue) {
                            setState(() {
                              newAd.size = newValue;
                              size = newValue;
                            }
                            );
                          },

                          items: <double>[1.5,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
                              .map<DropdownMenuItem<double>>((double value) {
                            return DropdownMenuItem<double>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          validator: (value)=>value==null?'please specify plot size':null,
                        ),
                      ),

                      SizedBox(width:10,),
                      Expanded(
                          child: SizedBox(
                            width: 30,
                            child: DropdownButtonFormField<String>(
                              value: sizeUnit,
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
                              hint: Text('Unit'),
                              style: TextStyle(color: Colors.black),


                              onChanged: (String newValue) {
                                setState(() {
                                  newAd.sizeUnit = newValue;
                                  sizeUnit = newValue;
                                }
                                );
                              },

                              items: <String>['Marla','Kanal']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              validator: (value)=>value==null?'please specify unit':null,

                            ),
                          ))
                    ],
                  ),


                  /*    Row(

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
                              value: floorValue,
                              icon: Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,

                              hint: Text('Floor'),
                              style: TextStyle(color: Colors.black),

                              underline: Container(
                                height: 10,
                                //  color: Colors.grey[400],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  newAd.floor=newValue;
                                  floorValue = newValue;
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

                      SizedBox(width: 2,),

                      Text("Size:",
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                      ),

                      SizedBox(width: 1,),


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
                              value: dropdownValue,

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
                                  newAd.size= newValue;
                                  dropdownValue = newValue;
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
                  ),*/

                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: <Widget>[

                      Expanded(
                          child: SizedBox(
                            width: 30,
                            child: DropdownButtonFormField<String>(
                              value: type,
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
                              hint: Text('Property Type'),
                              style: TextStyle(color: Colors.black),


                              onChanged: (String newValue) {
                                switch(newValue){
                                  case 'Office' : { hideWidget(); hideCatering();}
                                  break;
                                  case 'Wedding Hall' : { showWidget();}
                                }

                                setState(() {
                                  newAd.type = newValue;
                                  type = newValue;
                                }
                                );
                              },

                              items: <String>['Office','Wedding Hall', ]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              validator: (value)=>value==null?'please specify property type':null,

                            ),
                          )),
                      SizedBox(width:10),

                      Expanded(
                          child:SizedBox(

                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                  hintText: "Rent (e.g.10000)",
                                  border: OutlineInputBorder(),
                                ),
                                validator:((val) {
                                  if(val.length<1 ||int.tryParse(val)<500) return 'Enter correct amount';
                                  else return null;
                                }),
                                onChanged: (val) {

                                  setState(() {
                                    newAd.rent = int.parse(val);
                                    rent = int.parse(val);
                                  });
                                }),
                          )
                      ),


                    ],
                  ),

                  /*     Row(
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
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),

                              underline: Container(
                                height: 10,
                                //  color: Colors.grey[400],
                              ),
                              onChanged: (String newValue) {

                                switch(newValue){
                                  case ' Office ' : { hideWidget(); hideCatering();}
                                  break;
                                  case ' Wedding Hall ' : { showWidget();}
                                }

                                setState(() {
                                  newAd.type= newValue;
                                  type = newValue;
                                }
                                );
                              },

                              items: <String>[' Office ',' Wedding Hall ', ]
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

                      SizedBox(width:2),

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
                                newAd.rent =int.parse(val);
                                rent = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
*/
                  SizedBox(height: 10,),

                  Visibility(
                    visible: widgetVisible,
                    child: Row(
                      children: <Widget>[
/*
                        Container(
                          //  padding: EdgeInsets.all(2),
                          child: Text("Capacity:",
                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                          ),
                        ),
*/

                        SizedBox(width:0),


                        Expanded(
                            child:SizedBox(

                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(

                                    hintText: "Seating capacity (e.g. 200)",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator:((val) {
                                    if(val.length<1 ||int.tryParse(val)<500) return 'Enter correct value';
                                    else return null;
                                  }),
                                  onChanged: (val) {

                                    setState(() {
                                      newAd.capacity = int.parse(val);
                                      seatingCapacity = int.parse(val);
                                    });
                                  }),
                            )
                        ),

                       // SizedBox(width: 20,),

/*
                        Container(
                          //  padding: EdgeInsets.all(2),
                          child: Text("Catering:",
                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                          ),
                        ),
*/

                        SizedBox(width:10),

                        Expanded(
                            child: SizedBox(
                              width: 30,
                              child: DropdownButtonFormField<String>(
                                value: catering,
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
                                hint: Text('Catering'),
                                style: TextStyle(color: Colors.black),


                                onChanged: (String newValue) {
                                  switch(newValue){
                                    case 'Not-Available' : { hideCatering();}
                                    break;
                                    case 'Available' : { showCatering();}
                                  }

                                  setState(() {
                                    newAd.catering = newValue;
                                    catering = newValue;
                                  }
                                  );
                                },

                                items: <String>['Available','Not-Available']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: (value)=>value==null?'please specify vale':null,

                              ),
                            ))


                        /*  Expanded(
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
                                value: catering,

                                icon: Icon(Icons.expand_more),
                                iconSize: 24,
                                elevation: 16,

                                hint: Text('Catering'),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.0,
                                ),

                                underline: Container(
                                  height: 10,
                                  //  color: Colors.grey[400],
                                ),
                                onChanged: (String newValue) {

                                  switch(newValue){
                                    case ' Not Available ' : { hideCatering();}
                                    break;
                                    case ' Available ' : { showCatering();}
                                  }


                                  setState(() {
                                    newAd.catering = newValue;
                                    catering = newValue;
                                  }
                                  );
                                },

                                items: <String>['',' Not Available ',' Available ', ]
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
*/                      ],
                    ),
                  ),


                  SizedBox(height: 10,),

                  Visibility(
                    visible: cateringVisible,
                    child: Row(
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.all(2),
                          child: Text("Charges:",
                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal) ,
                          ),
                        ),

                        SizedBox(width: 0),

                        Expanded(
                            child:SizedBox(

                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(

                                    hintText: "Minimum (e.g. 400 etc)",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator:((val) {
                                    if(val.length<1 ||int.tryParse(val)<10) return 'Enter correct amount';
                                    else return null;
                                  }),
                                  onChanged: (val) {

                                    setState(() {
                                      newAd.minCharges = int.parse(val);
                                      minChargesPerPerson = int.parse(val);
                                    });
                                  }),
                            )
                        ),

                        SizedBox(width: 10,),

                        Expanded(
                            child:SizedBox(

                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(

                                    hintText: "Maximum (e.g. 1800 etc)",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator:((val) {
                                    if(val.length<1 ||int.tryParse(val)<100) return 'Enter correct amount';
                                    else return null;
                                  }),
                                  onChanged: (val) {

                                    setState(() {
                                      newAd.maxCharges = int.parse(val);
                                      maxChargesPerPerson = int.parse(val);
                                    });
                                  }),
                            )
                        ),


                      ],
                    ),
                  ),


                  SizedBox(height: 10,),
/*

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
                        newAd.desc= val;
                        //password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 55,
                    child: SearchMapPlaceWidget(
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


                          */
/*
                      final geolocation = await place.geolocation;
                      latlngVar = geolocation.coordinates;
                      newAd.location = latlngVar;
                      print(newAd.location);
                      */
/*

                        }
                    ),

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
                            child: LocationWidget()
                        )
                    ),
                  ),
*/
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






                  RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text("Next"),
                      onPressed: () async {

                        if (_formKey.currentState.validate()) {

                          //await db.collection("Ads").add(newAd.toJson());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommAdSecondStep()),
                          );
                        }
                      }

                  ),
                ],
              ),
            )));
  }

}