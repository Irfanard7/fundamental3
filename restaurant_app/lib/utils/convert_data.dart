import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

RestaurantList convertData(RestaurantDetail detailRestaurant) {
  return RestaurantList(
    id: detailRestaurant.id,
    name: detailRestaurant.name,
    description: detailRestaurant.description,
    pictureId: detailRestaurant.pictureId,
    city: detailRestaurant.city,
    rating: detailRestaurant.rating.toDouble(),
  );
}
