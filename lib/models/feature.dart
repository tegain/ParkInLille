import 'package:flutter/cupertino.dart';
import 'package:parklille/models/feature_fields.dart';
import 'package:latlong/latlong.dart';

class Feature {
  String datasetId;
  String recordId;
  String recordTimestamp;
  FeatureFields fields;

  Feature(
      {String datasetId,
      String recordId,
      @required dynamic fields,
      String recordTimestamp})
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

  LatLng getLatLng() {
    return LatLng(
        fields.geometry.coordinates[1], fields.geometry.coordinates[0]);
  }
}
