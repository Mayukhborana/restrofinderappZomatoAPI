import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class ZomatoClient {
  final _apiKey = '1b3c8b37ea96785391fa55c288ac385c';
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);

    return jsonObject;
  }

  Future<List<Location>> fetchLocations(String query) async {
    final results = await request(
        path: 'locations', parameters: {'query': query, 'count': '10'});
    final suggestions = results['location_suggestions'];

    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });
    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }
}
