import 'package:flutter/material.dart';
import 'package:mobileapp/model/order.dart';
import 'package:mobileapp/model/platos.dart';

class OrderScreen extends StatefulWidget {
  final List<Plato> dishes;
  const OrderScreen({
    Key? key,
    required this.dishes,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.dishes.clear();
                });
              },
              child: const Text(
                "Clear Order",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.dishes.length,
              itemBuilder: (context, index) {
                final dish = widget.dishes[index];
                return ListTile(
                  title: Text(
                    dish.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "${dish.price}€",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      setState(() {
                        widget.dishes.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<Item> items = [];
              for (final dish in widget.dishes) {
                final item = Item(dish);
                items.add(item);
              }
              Order order = Order(items);
              guardaPlatos(order);
              setState(() {
                widget.dishes.clear();
              });
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Confirm Order",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
