import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:parklille/widgets/map_marker.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

import 'package:parklille/services/features.dart';
import 'package:parklille/types/map_center.dart';

class Map extends StatelessWidget {
  final MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  StreamController<LatLng> markerLocationStream = StreamController();

  Map({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeaturesService.getFeatures();
    markerLocationStream.stream.listen((onData) {
      print('ON DATA ${onData.latitude}');
    });
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: MapMarkers().buildMarkers(),
        zoomToCurrentLocationOnLoad: true,
        onLocationUpdate: (LatLng pos) => print("onLocationUpdate ${pos.toString()}"),
        moveToCurrentLocationFloatingActionButton: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)]),
          child: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ));

    return FlutterMap(
      options: MapOptions(
        center: LatLng(MapCenter.latitude, MapCenter.longitude),
        zoom: 9,
        plugins: [
          UserLocationPlugin(),
        ],
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
          markers: MapMarkers().buildMarkers(),
        ),
        userLocationOptions
      ],
      mapController: mapController,
    );
  }

  void dispose() {
    markerLocationStream.close();
  }
}
