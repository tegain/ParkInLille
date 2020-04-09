import 'package:flutter/material.dart';

class MyLocationButton extends StatelessWidget {
  final double top;
  final double left;
  final double bottom;
  final double right;
  final Function onTap;

  MyLocationButton({Key key, @required this.onTap, this.top, this.left, this.right = 24, this.bottom = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: bottom,
        right: right,
        left: left,
        top: top,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 2.0,
          child: InkWell(
            radius: 20.0,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.my_location,
                size: 24.0,
              ),
            ),
            onTap: onTap,
          ),
        ));
  }
}
