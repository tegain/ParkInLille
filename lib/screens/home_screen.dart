import 'package:flutter/material.dart';
import 'package:parklille/models/feature.dart';
import 'package:parklille/widgets/map.dart';
import 'package:parklille/widgets/map_filters.dart';
import 'package:parklille/widgets/map_marker_dialog.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Feature selectedFeature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Map(onClickMarker: displayMarkerDialog,),
        selectedFeature != null ? MapMarkerDialog(feature: selectedFeature, onCloseDialog: _resetSelectedFeature) : null,
        MapFilters(bottom: 72, right: 16),
      ].where(_notNull).toList(),
    ));
  }

  void displayMarkerDialog(Feature feature) {
    setState(() {
      selectedFeature = feature;
    });
    print(feature.getLabel());
  }

  void _resetSelectedFeature() {
    setState(() {
      selectedFeature = null;
    });
  }

  bool _notNull(Object o) => o != null;
}
