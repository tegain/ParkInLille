import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parklille/models/feature.dart';
import 'package:parklille/widgets/map.dart';
import 'package:parklille/widgets/map_filters.dart';
import 'package:parklille/widgets/map_marker_dialog.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  StreamSubscription<Position> positionStream;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

  void dispose() {
    positionStream.cancel();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Feature selectedFeature;
  Position userCurrentLocation;

  @override
  void initState() {
    super.initState();
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    widget.positionStream = geolocator.getPositionStream(locationOptions).listen((Position position) {
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      setState(() {
        userCurrentLocation = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentPosition();

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Map(
          onClickMarker: _displayMarkerDialog,
          userLocation: userCurrentLocation,
        ),
        selectedFeature != null
            ? MapMarkerDialog(feature: selectedFeature, onCloseDialog: _resetSelectedFeature)
            : null,
        MapFilters(bottom: 72, right: 16),
      ].where(_notNull).toList(),
    ));
  }

  void _displayMarkerDialog(Feature feature) {
    setState(() {
      selectedFeature = feature;
    });
  }

  void _resetSelectedFeature() {
    setState(() {
      selectedFeature = null;
    });
  }

  Future<void> _setCurrentPosition() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userCurrentLocation = position;
    });
  }

  bool _notNull(Object o) => o != null;
}
