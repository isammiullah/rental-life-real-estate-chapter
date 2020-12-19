import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class nonCommAd{
  // final String adTitle;
  // final String adDescription;
  //Right now, a user can select only one image for his Ad.
  //final Image adImages;

  String title ;
  int beds ;
  int bath ;
  String floor ;
  double size ;
  String sizeUnit;
  int rent ;
  String desc ;
  String type;
  String category;
  String city;
  LatLng location;
//  final String error ;
  //final String floorValue;
  //final String dropdownValue ;

  nonCommAd({this.title, this.beds, this.bath, this.floor,this.size,this.sizeUnit,this.rent,this.desc,this.category,this.type, this.location,this.city});


  Map<String, dynamic> toJson() => {
    'title': title,
    'beds': beds,
    "bath": bath,
    'floor': floor,
    'size' : size,
    'size unit': sizeUnit,
    'rent' : rent,
    'desc' : desc,
    'type': type,
    'category': category,
    'city': city,
    'location' : location,
  };
}