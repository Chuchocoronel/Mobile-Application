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
              Icons.check,
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
                  child: Center(
                    child: Text(
                      dishes![index].name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[300],
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
