import 'package:parklille/models/feature_geometry.dart';

class FeatureFields {
  String etat;
  String ville;
  int dispo;
  FeatureGeometry geometry;
  int max;
  String aff;
  String libelle;
  String datemaj;
  String adresse;
  String id;

  FeatureFields({
    this.etat,
    this.ville,
    this.dispo,
    this.geometry,
    this.max,
    this.aff,
    this.libelle,
    this.datemaj,
    this.adresse,
    this.id,
  });

  factory FeatureFields.fromJson(Map<String, dynamic> json) {
    return FeatureFields(
      etat: json['etat'],
      ville: json['ville'],
      dispo: json['dispo'] as int,
      geometry: FeatureGeometry.fromJson(json['geometry']),
      max: json['max'] as int,
      aff: json['aff'],
      libelle: json['libelle'],
      datemaj: json['datemaj'],
      adresse: json['adresse'],
      id: json['id'],
    );
  }
}
