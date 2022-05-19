import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  SearchRestaurantResult? _searchResult;
  SearchResultState? _state;
  String _message = '';
  String _query = '';

  SearchRestaurantResult? get result => _searchResult;
  SearchResultState? get state => _state;
  String get message => _message;
  String get query => _query;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = SearchResultState.loading;
      _query = query;
      final search = await apiService.getRestaurantSearch(query);
      if (search.restaurants.isEmpty) {
        _state = SearchResultState.noData;
        notifyListeners();
        return _message = "Data is Not Found";
      } else {
        _state = SearchResultState.hasData;
        notifyListeners();
        return _searchResult = search;
      }
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = "Sorry, please check your internet connection";
    }
  }
}
