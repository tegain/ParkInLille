import 'package:flutter/cupertino.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parklille/types/types.dart';

class Map extends StatelessWidget {
  final Function onMapCreated;

  Map({ Key key, @required this.onMapCreated }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(MapCenter.latitude, MapCenter.longitude),
        zoom: 12,
      ),
      styleString: MapboxStyles.MAPBOX_STREETS,
    );
  }
}
