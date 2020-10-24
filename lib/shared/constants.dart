import 'package:flutter/material.dart';

const textInputDecorationForEmail = InputDecoration(
  hintText: 'Email',
  fillColor: Colors.white,
  filled: true,
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
);

const textInputDecorationForPassword = InputDecoration(
  hintText: 'Password',
  fillColor: Colors.white,
  filled: true,
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
);

const textInputDecorationForString = InputDecoration(
  hintText: '',
  fillColor: Colors.white,
  filled: true,
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
);
