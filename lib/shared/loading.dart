import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[50],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.red[600],
          size: 50,
        ),
      ),
    );
  }
}
