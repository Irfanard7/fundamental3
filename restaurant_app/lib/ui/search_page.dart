import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String queries = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.redAccent,
      ),
      body: ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(apiService: ApiService()),
        child: Consumer<SearchProvider>(builder: (context, state, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        queries = value;
                      });
                      state.fetchSearchRestaurant(value);
                    },
                    autofocus: true,
                    cursorColor: Colors.redAccent,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Find Menus or Restaurant...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: queries.isEmpty
                      ? const Center(child: Text(''))
                      : _searchRestaurant(context),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _searchRestaurant(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, state, _) {
      if (state.state == SearchResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == SearchResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var restaurant = state.result!.restaurants[index];
            return CardRestaurant(restaurant: restaurant);
          },
          itemCount: state.result!.restaurants.length,
        );
      } else if (state.state == SearchResultState.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == SearchResultState.error) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
            child: Text('Sorry, please check your internet connection.'));
      }
    });
  }
}
