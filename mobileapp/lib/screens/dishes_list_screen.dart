import 'package:flutter/material.dart';
import 'package:mobileapp/model/platos.dart';

class DishesListScreen extends StatelessWidget {
  const DishesListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: platosSnapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Plato>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 16 / 9,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final dishes = snapshot.data;
              return GestureDetector(
                onTap: () {},
                child: GridTile(
                  child: Container(
                    child: Center(
                      child: Text(dishes![index].name),
                    ),
                    color: Colors.amber,
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
