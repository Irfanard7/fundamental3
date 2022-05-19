

import 'package:restaurant_app/data/model/restaurant_list.dart';

class SearchRestaurantResult {
  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantList> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) => SearchRestaurantResult(
    error: json['error'],
    founded: json['founded'],
    restaurants: List<RestaurantList>.from(json['restaurants'].map((e) => RestaurantList.fromJson(e))),
  );
}