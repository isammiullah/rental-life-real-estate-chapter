import 'package:flutter/material.dart';

class UserAd{
  final String adTitle;
  final String adDescription;
  //Right now, a user can select only one image for his Ad.
  final Image adImages;

  UserAd(this.adTitle, this.adDescription, this.adImages);
  
}