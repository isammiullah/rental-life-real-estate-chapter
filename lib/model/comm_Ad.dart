import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class commAd{
  // final String adTitle;
  // final String adDescription;
  //Right now, a user can select only one image for his Ad.
  //final Image adImages;

  String title ;
  String floor ;
  String size ;
  String rent ;
  String desc ;
  String type;
  String category;
  String capacity;
  String catering;
  String minCharges;
  String maxCharges;
  Geolocation location;
//  final String error ;
  //final String floorValue;
  //final String dropdownValue ;

  commAd({this.title, this.catering, this.capacity, this.floor,this.size,this.rent,this.desc,this.category,this.type, this.location, this.maxCharges, this.minCharges});


  Map<String, dynamic> toJson() => {
    'title': title,
    'floor': floor,
    'size' : size,
    'type'  : type,
    'rent' : rent,
    'capacity': capacity,
    'catering': catering,
    'minimum hall charges' : minCharges,
    'maximum hall charges' : maxCharges,
    'desc' : desc,

    'category': category,
    'location' : location,
  };
}
