import 'package:flutter/material.dart';
import 'package:mobileapp/model/restaurant.dart';

class RestaurantsListScreen extends StatelessWidget {
  const RestaurantsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () {},
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
