import 'package:flutter/material.dart';
import 'package:mobileapp/model/restaurant.dart';
import 'package:mobileapp/screens/dishes_list_screen.dart';

class RestaurantsListScreen extends StatelessWidget {
  const RestaurantsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants near you"),
      ),
      body: StreamBuilder(
        stream: restaurantsSnapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Restaurant>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 16 / 9,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final restaurants = snapshot.data;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DishesListScreen(
                        restaurant: restaurants![index],
                      ),
                    ),
                  );
                },
                child: GridTile(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(restaurants![index].name),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
