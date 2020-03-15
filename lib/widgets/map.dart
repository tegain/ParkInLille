import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:parklille/models/feature.dart';
import 'package:parklille/services/features.dart';
import 'package:parklille/types/map_center.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  Map({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeaturesService.getFeatures();
    return FlutterMap(
      options: MapOptions(
        center: LatLng(MapCenter.latitude, MapCenter.longitude),
        zoom: 11.0,
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
          markers: _getMarkers(),
        ),
      ],
    );
  }

  void showMarkerDialog(Feature feature) {
    print(feature.fields.libelle);
  }

  List<Marker> _getMarkers() {
    return List.generate(FeaturesService.getFeatures().length, (int index) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: FeaturesService.getFeatures()[index].getLatLng(),
        builder: (BuildContext ctx) => Container(
          child: InkWell(
            onTap: () {
              showMarkerDialog(FeaturesService.getFeatures()[index]);
            },
            child: FlutterLogo(),
          ),
        ),
      );
    });
  }
}
