import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:parklille/types/types.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  Map({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(MapCenter.latitude, MapCenter.longitude),
              builder: (BuildContext ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
