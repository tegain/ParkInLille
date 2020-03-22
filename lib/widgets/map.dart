import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

import 'package:parklille/widgets/map_marker.dart';
import 'package:parklille/widgets/user_marker.dart';
import 'package:latlong/latlong.dart';

import 'package:parklille/services/features.dart';

class Map extends StatelessWidget {
  final Function onClickMarker;
  final MapController mapController;
  final LatLng mapCenter;

  Position userLocation;

  Map({Key key, @required this.mapController, @required this.onClickMarker, @required this.userLocation, @required this.mapCenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeaturesService.getFeatures();

    return FlutterMap(
      options: MapOptions(
        center: mapCenter,
        zoom: 2,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': FlutterConfig.get('MAPBOX_TOKEN'),
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(
          markers: [
            ...MapMarkers().buildMarkers(onClickMarker: onClickMarker),
            UserMarker(position: userLocation).getMarker(),
          ],
        ),
      ],
      mapController: mapController,
    );
  }
}
