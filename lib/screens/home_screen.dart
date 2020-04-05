import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:parklille/models/feature.dart';
import 'package:parklille/types/map_center.dart';
import 'package:parklille/widgets/map.dart';
import 'package:parklille/widgets/map_filters.dart';
import 'package:parklille/widgets/map_marker_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:parklille/widgets/my_location_button.dart';

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
  final MapController mapController = MapController();
  Feature selectedFeature;
  Position userCurrentLocation;
  LatLng mapCenter = LatLng(MapCenter.latitude, MapCenter.longitude);

  MapboxNavigation _directions;
  bool _arrived = false;
  String _platformVersion = 'Unknown';
  double _distanceRemaining, _durationRemaining;

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

    _initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentPosition();

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Map(
          mapController: mapController,
          mapCenter: mapCenter,
          userLocation: userCurrentLocation,
          onClickMarker: _displayMarkerDialog,
        ),
        selectedFeature != null
            ? MapMarkerDialog(feature: selectedFeature, onCloseDialog: _resetSelectedFeature, onTriggerNavigation: _startNavigation,)
            : null,
        MapFilters(bottom: 72, right: 16),
        MyLocationButton(onTap: _centerMapToUser, bottom: 16, right: 16),
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

  Future<Position> _setCurrentPosition() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userCurrentLocation = position;
    });
    return position;
  }

  bool _notNull(Object o) => o != null;

  Future<void> _centerMapToUser() async {
    var position = await _setCurrentPosition();
    var center = LatLng(position.latitude, position.longitude);
    setState(() {
      mapCenter = center;
    });
    mapController.move(center, 11);
  }

  Future<void> _initPlatformState() async {
    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });

      if (arrived) {
        await Future.delayed(Duration(seconds: 3));
        await _directions.finishNavigation();
      }
    });

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException catch(e) {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _startNavigation({ Feature to }) async {
    final origin = Location(name: 'Ma position', latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude);
    final destination = Location(name: to.getLabel(), latitude: to.getLatLng().latitude, longitude: to.getLatLng().longitude);

    await _directions.startNavigation(
        origin: origin,
        destination: destination,
        mode: NavigationMode.drivingWithTraffic,
        simulateRoute: true,
        language: "French",
        units: VoiceUnits.metric);
  }
}
