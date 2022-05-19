import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class FoodList extends StatelessWidget {
  final List<Category> foods;

  const FoodList({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 30,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage('images/food.jpg'),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                foods[index].name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
      itemCount: foods.length,
    );
  }
}
