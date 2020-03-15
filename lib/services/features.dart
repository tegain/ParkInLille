import 'dart:convert';

import 'package:parklille/models/feature.dart';

class Features {
  static final String fixtures =
      '[{"datasetid":"disponibilite-parkings","recordid":"c98fc09f5ae72732daf32fa2c1b5584a5e431be6","fields":{"etat":"OUVERT","ville":"Tourcoing","dispo":198,"geometry":{"type":"Point","coordinates":[3.1588613346739,50.725397814831]},"max":434,"aff":"198","libelle":"Parking Hotel de Ville","datemaj":"2020-03-01T15:04:00+01:00","adresse":"Rue de la Bienfaisance","id":"TCG0001"},"record_timestamp":"2020-03-01T15:06:15.743+01:00"},{"datasetid":"disponibilite-parkings","recordid":"f92bbb9ed7fac06f57f429147553aaea9fdad067","fields":{"etat":"OUVERT","ville":"Lille","dispo":219,"geometry":{"type":"Point","coordinates":[3.0626957915787,50.631013293077]},"max":203,"aff":"205","libelle":"Parking Republique","datemaj":"2020-03-01T15:04:00+01:00","adresse":"Place de la Republique","id":"LIL0001"},"record_timestamp":"2020-03-01T15:06:15.743+01:00"},{"datasetid":"disponibilite-parkings","recordid":"673fdbd036b7cb5eb3e475e55b1cbb69152ca35a","fields":{"etat":"OUVERT","ville":"Lille","dispo":143,"geometry":{"type":"Point","coordinates":[3.0583061274138,50.635107671686]},"max":300,"aff":"140","libelle":"Parking Plaza","datemaj":"2020-03-01T15:04:00+01:00","adresse":"Rue Nationale","id":"LIL0002"},"record_timestamp":"2020-03-01T15:06:15.743+01:00"}]';

//  Future _loadProducts() async {
//    final response = await http.get('https://api.com');
//    return response.body;
//  }

  static List<Feature> getFeatures() {
    List<dynamic> jsonParsed = json.decode(Features.fixtures);
    return jsonParsed.map((fixture) => Feature.fromJson(fixture)).toList();
  }
}
