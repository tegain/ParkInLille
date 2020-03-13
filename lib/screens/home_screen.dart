import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parklille/widgets/map.dart';
import 'package:parklille/widgets/map_filters.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Map(onMapCreated: _onMapCreated,),
        MapFilters(),
      ],
    ));
  }

  _onMapCreated(MapboxMapController mapController) {
    _mapController = mapController;
  }
}
