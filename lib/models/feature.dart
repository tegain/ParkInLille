import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:intl/intl.dart';

import 'package:parklille/models/feature_fields.dart';
import 'package:parklille/types/parking_color.dart';

class Feature {
  String datasetId;
  String recordId;
  String recordTimestamp;
  FeatureFields fields;

  Feature({String datasetId, String recordId, @required dynamic fields, String recordTimestamp})
      : this.datasetId = datasetId,
        this.recordId = recordId,
        this.fields = FeatureFields.fromJson(fields),
        this.recordTimestamp = recordTimestamp;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      datasetId: json['datasetid'],
      recordId: json['recordid'],
      recordTimestamp: json['record_imestamp'],
      fields: json['fields'],
    );
  }

  String getLabel() => fields.libelle;

  LatLng getLatLng() => LatLng(fields.geometry.coordinates[1], fields.geometry.coordinates[0]);

  String getAvailability() => fields.dispo.toString();

  double getAvailabilityPercentage() {
    return (fields.dispo * 100 / fields.max).roundToDouble() / 100;
  }

  bool isClosed() {
    return fields.etat == 'FERME';
  }

  bool isFull() {
    return fields.etat == 'COMPLET';
  }

  bool isOpen() {
    return fields.etat == 'OUVERT';
  }

  Color getAvailabilityColor(double availabilityPercentage) {
    double availability = availabilityPercentage * 100;

    if (availability > 50) {
      return ParkingAvailabilityColor.available;
    }
    if (availability > 25) {
      return ParkingAvailabilityColor.hurry;
    }
    return ParkingAvailabilityColor.full;
  }

  String getAvailabilityLabel() {
    if (isFull() || isClosed()) {
      return fields.etat;
    }
    return getAvailability();
  }

  Color getParkingColor() {
    if (isFull()) {
      return ParkingStateColor.full;
    }
    if (isClosed()) {
      return ParkingStateColor.closed;
    }
    return ParkingStateColor.open;
  }

  String getUpdatedTime() {
    final dateFormat = DateFormat('dd-MM-yyyy hh:mm');
    return dateFormat.format(DateTime.parse(fields.datemaj));
  }
}
