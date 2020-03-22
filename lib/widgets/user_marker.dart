import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:parklille/types/map_center.dart';

class UserMarker {
  Position position;

  final double markerWidth = 18;
  final double markerHeight = 18;

  UserMarker({ @required this.position });

  Marker getMarker() {
    double latitude = (position != null) ? position.latitude : MapCenter.latitude;
    double longitude = (position != null) ? position.longitude : MapCenter.longitude;

    return Marker(
      width: markerWidth,
      height: markerHeight,
      point: LatLng(latitude, longitude),
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (BuildContext ctx) {
        return Container(
          width: markerWidth,
          height: markerHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.lightBlue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Color(0xFF4FC3F7).withOpacity(0.3),
                offset: Offset(0, 0),
                spreadRadius: 12,
                blurRadius: 0,
              ),
              BoxShadow(
                color: Color(0xFF4FC3F7).withOpacity(0.3),
                offset: Offset(0, 0),
                spreadRadius: 24,
                blurRadius: 0,
              )
            ]
          ),
        );
      },
    );
  }
}
