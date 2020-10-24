import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class nonCommAd{
 // final String adTitle;
 // final String adDescription;
  //Right now, a user can select only one image for his Ad.
  //final Image adImages;

  String title ;
  String beds ;
  String bath ;
  String floor ;
  String size ;
  String rent ;
  String desc ;
  String type;
  String category;
  Geolocation location;
//  final String error ;
  //final String floorValue;
  //final String dropdownValue ;

  nonCommAd({this.title, this.beds, this.bath, this.floor,this.size,this.rent,this.desc,this.category,this.type, this.location});


 Map<String, dynamic> toJson() => {
  'title': title,
  'beds': beds,
  "bath": bath,
  'floor': floor,
  'size' : size,
  'rent' : rent,
  'desc' : desc,
  'type': type,
  'category': category,
   'location' : location,
 };
}
