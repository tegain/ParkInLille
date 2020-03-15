class FeatureGeometry {
  String type;
  List<dynamic> coordinates;

  FeatureGeometry({this.type, this.coordinates});

  factory FeatureGeometry.fromJson(Map<String, dynamic> json) {
    List<double> coordinates = json['coordinates'].cast<double>();
    return FeatureGeometry(type: json['type'], coordinates: coordinates);
  }
}
