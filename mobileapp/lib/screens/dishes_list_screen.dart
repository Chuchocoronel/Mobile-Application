import 'package:flutter/material.dart';
import 'package:mobileapp/model/platos.dart';
import 'package:mobileapp/screens/order_screen.dart';

class DishesListScreen extends StatefulWidget {
  final num table;
  const DishesListScreen({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  State<DishesListScreen> createState() => _DishesListScreenState();
}

class _DishesListScreenState extends State<DishesListScreen> {
  String typeFilter = "dish";
  List<Plato> order = [];

  Widget buildFilterButton(String type) {
    IconData icon = Icons.restaurant;
    if (type == "dish") {
      icon = Icons.restaurant;
    } else if (type == "drink") {
      icon = Icons.local_drink_rounded;
    } else if (type == "dessert") {
      icon = Icons.cake;
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          typeFilter = type;
        });
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            type,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: typeFilter == type ? Colors.red : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Service"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    dishes: order,
                    table: widget.table,
                  ),
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildFilterButton("dish"),
              buildFilterButton("drink"),
              buildFilterButton("dessert"),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: platosSnapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<Map<String, List<Plato>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final dishes = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: dishes[typeFilter]!.length,
                  itemBuilder: (context, index) {
                    final plato = dishes[typeFilter]![index];
                    return GridTile(
                      child: ElevatedButton(
                        onPressed: () {
                          order.add(plato);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              plato.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "${plato.price}€",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            if (plato.type == 'drink')
                              const Icon(
                                Icons.local_drink_rounded,
                                size: 30,
                                color: Colors.lightBlueAccent,
                              ),
                            if (plato.type == 'dish')
                              const Icon(
                                Icons.restaurant,
                                size: 30,
                                color: Colors.brown,
                              ),
                            if (plato.type == 'dessert')
                              const Icon(
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
          ),
        ],
      ),
    );
  }
}
