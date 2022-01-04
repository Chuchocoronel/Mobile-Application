import 'package:flutter/material.dart';
import 'package:mobileapp/model/platos.dart';
import 'package:mobileapp/screens/order_screen.dart';

class DishesListScreen extends StatefulWidget {
  const DishesListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DishesListScreen> createState() => _DishesListScreenState();
}

class _DishesListScreenState extends State<DishesListScreen> {
  @override
  Widget build(BuildContext context) {
    List<Plato> order = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Service"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(dishes: order),
                ),
              )
                  .then((result) {
                if (result != null) {
                  setState(() => order = result);
                }
              });
            },
            icon: const Icon(
              Icons.check_circle_outline,
              size: 40,
            ),
          ),
        ],
      ),
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
              return GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    order.add(dishes![index]);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        dishes![index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${dishes[index].price}€",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      if (dishes[index].type == 'drink')
                        Icon(
                          Icons.local_drink_rounded,
                          size: 30,
                          color: Colors.lightBlueAccent,
                        ),
                      if (dishes[index].type == 'dish')
                        Icon(
                          Icons.restaurant,
                          size: 30,
                          color: Colors.brown,
                        ),
                      if (dishes[index].type == 'dessert')
                        Icon(
                          Icons.cake,
                          size: 30,
                          color: Colors.white70,
                        ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
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
