import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:parklille/models/feature.dart';
import 'package:parklille/types/parking_state.dart';
import 'package:parklille/constants.dart' as Constants;

class FeaturesService extends ChangeNotifier {
  final Map<String, bool> _mapFilters = {
    'showClosedParkings': true,
    'showFullParkings': true,
  };
  String _features = '';

  Future fetchFeatures() async {
    final response = await http.get(Constants.API_URL);
    final body = json.decode(response.body);
    if (body['records'] != null) {
      _features = json.encode(body['records']);
    }
    return response.body;
  }

  void setFilter(String filter, bool value) {
    _mapFilters[filter] = value;
    notifyListeners();
  }

  bool getFilter(String filter) {
    return _mapFilters[filter];
  }

  List<Feature> getFeatures() {
    List<dynamic> jsonParsed = json.decode(_features);
    return jsonParsed.map((feature) => Feature.fromJson(feature)).where((f) {
      return f.fields.etat == ParkingState.open ||
          (f.fields.etat == ParkingState.closed && _mapFilters['showClosedParkings']) ||
          (f.fields.etat == ParkingState.full && _mapFilters['showFullParkings']);
    }).toList();
  }
}
