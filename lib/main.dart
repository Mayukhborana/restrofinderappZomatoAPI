import 'package:flutter/material.dart';
import 'package:restaurant_finder/UI/main_screen.dart';
import 'package:restaurant_finder/bloc/bloc_provider.dart';
import 'package:restaurant_finder/bloc/favorite_bloc.dart';
import 'package:restaurant_finder/bloc/location_bloc.dart';

void main() => runApp(RestaurantFinder());

class RestaurantFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: BlocProvider<FavoriteBloc>(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant Finder',
          theme: ThemeData(primarySwatch: Colors.red),
          home: MainScreen(),
        ),
      ),
    );
  }
}
