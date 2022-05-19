import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum DetailResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant(restaurantId);
  }

  late RestaurantDetailResult _detailRestaurantResult;
  late DetailResultState _state;
  String _message = '';

  RestaurantDetailResult get detailRestaurant => _detailRestaurantResult;
  DetailResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = DetailResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getRestaurantDetail(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.noData;
        notifyListeners();
        return _message = "Data is Empty";
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = "Sorry, please check your internet connection";
    }
  }
}
