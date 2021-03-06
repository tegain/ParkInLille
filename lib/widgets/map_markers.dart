import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:parklille/models/feature.dart';
import 'package:parklille/widgets/triangle_painter.dart';

class MapMarkers {
  List<Marker> buildMarkers({Function onClickMarker, List<Feature> features}) {
    const double markerWidth = 88;
    const double markerHeight = 36;
    const double arrowHeight = 6;

    return List.generate(features.length, (int index) {
      var feature = features[index];
      Color availabilityColor = feature.getAvailabilityColor(feature.getAvailabilityPercentage());

      return Marker(
        width: markerWidth,
        height: markerHeight + arrowHeight,
        point: feature.getLatLng(),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (BuildContext ctx) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  height: markerHeight,
                  width: markerWidth,
                  child: InkWell(
                    onTap: () {
                      onClickMarker(feature);
                    },
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Container(
                              width: markerWidth,
                              height: markerHeight,
                              child: Row(
                                  children: feature.isOpen()
                                      ? <Widget>[
                                          Container(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              value: feature.getAvailabilityPercentage(),
                                              strokeWidth: 4,
                                              backgroundColor: Colors.white,
                                              valueColor: AlwaysStoppedAnimation<Color>(availabilityColor),
                                            ),
                                            margin: EdgeInsets.only(right: 12),
                                          ),
                                          Text(
                                            feature.getAvailabilityLabel(),
                                            style: TextStyle(height: 1.4),
                                            textAlign: TextAlign.start,
                                          ),
                                        ]
                                      : [
                                          Container(
                                            width: markerWidth - 16,
                                            height: 24,
                                            child: Text(
                                              feature.getAvailabilityLabel(),
                                              style: TextStyle(
                                                  height: 2,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.8),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ])),
                        )),
                  ),
                ),
                Positioned(
                  left: markerWidth / 2.0 - 7.5,
                  top: markerHeight,
                  child: CustomPaint(
                    size: Size(15.0, arrowHeight),
                    painter: TrianglePainter(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
