import 'package:flutter/material.dart';
import 'package:mobileapp/model/restaurant.dart';

class DishesListScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DishesListScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: restaurant.dishes.length,
              itemBuilder: (context, index) {
                final dish = restaurant.dishes[index];
                return ListTile(
                  title: Text(dish.name),
                  subtitle: const Text("Description"),
                  trailing: Row(
                    children: [
                      Text("${dish.price}€"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
