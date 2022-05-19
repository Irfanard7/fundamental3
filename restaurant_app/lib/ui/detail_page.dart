import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/utils/convert_data.dart';
import 'package:restaurant_app/widgets/drink_list.dart';
import 'package:restaurant_app/widgets/food_list.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';
  final String id;

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), restaurantId: id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == DetailResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == DetailResultState.hasData) {
              final restaurant = state.detailRestaurant;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Hero(
                            tag: restaurant.restaurant.pictureId,
                            child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/large/' +
                                    restaurant.restaurant.pictureId)),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigation.back();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                          child: Text(
                            restaurant.restaurant.name,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(right: 16.0, top: 10.0),
                          child: Consumer<DatabaseProvider>(
                            builder: (context, provider, child) {
                              return FutureBuilder<bool>(
                                future: provider
                                    .isFavorite(restaurant.restaurant.id),
                                builder: (context, snapshot) {
                                  var isFavorite = snapshot.data ?? false;
                                  return isFavorite
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () =>
                                              provider.removeFavorite(
                                                  restaurant.restaurant.id),
                                        )
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                          onPressed: () => provider.addFavorite(
                                            convertData(restaurant.restaurant),
                                          ),
                                        );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          restaurant.restaurant.city,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          restaurant.restaurant.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        restaurant.restaurant.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        'Foods',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        FoodList(
                          foods: restaurant.restaurant.menus.foods,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 32.0),
                      child: Divider(
                        thickness: 4,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        'Drinks',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        DrinkList(drinks: restaurant.restaurant.menus.drinks),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state.state == DetailResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == DetailResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                  child: Text('Sorry, please check your internet connection.'));
            }
          },
        ),
      ),
    );
  }
}
