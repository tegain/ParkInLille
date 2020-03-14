import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parklille/types/types.dart';
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
        Map(onMapCreated: _onMapCreated, onStyleLoaded: _onStyleLoaded,),
        MapFilters(),
      ],
    ));
  }

  void _onMapCreated(MapboxMapController mapController) {
    _mapController = mapController;
  }

  void _onStyleLoaded() {
    _mapController.addCircle(CircleOptions())
    _mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(
            MapCenter.latitude,
            MapCenter.longitude
        ),
        textField: 'Coucou',

//        iconImage: 'airport-15',
      ),
    );

    _mapController.onSymbolTapped.add(_onSymbolTapped);
  }

  _onSymbolTapped(Symbol symbol) {
    print('Symbol: $symbol');
  }
}
