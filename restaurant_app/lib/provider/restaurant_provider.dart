import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

enum ListResultState { loading, noData, hasData, error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantListResult _restaurantResult;
  late ListResultState _state;
  String _message = '';

  RestaurantListResult get result => _restaurantResult;
  ListResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ListResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ListResultState.noData;
        notifyListeners();
        return _message = "Data is Empty";
      } else {
        _state = ListResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ListResultState.error;
      notifyListeners();
      return _message = "Sorry, please check your internet connection";
    }
  }
}
