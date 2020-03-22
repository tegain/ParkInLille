import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:parklille/types/map_center.dart';

class UserMarker {
  Position position;

  final double markerWidth = 80;
  final double markerHeight = 80;

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
        return InkWell(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                height: markerHeight,
                width: markerWidth,
                child: InkWell(
                  onTap: () {
                    print('click user marker');
                  },
                  child: Icon(Icons.directions_car),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
