import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';
import 'package:restaurant_finder/bloc/bloc.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
