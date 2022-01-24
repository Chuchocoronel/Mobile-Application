import 'package:flutter/material.dart';
import 'package:mobileapp/model/order.dart';
import 'package:mobileapp/model/platos.dart';

class OrderScreen extends StatefulWidget {
  final List<Plato> dishes;
  final num table;
  const OrderScreen({
    Key? key,
    required this.dishes,
    required this.table,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  num totalPrice(List<Plato> items) {
    num total = 0;
    for (final item in items) {
      total += item.price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order for table Nº${widget.table}"),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(false);
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
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "${dish.price}€",
                    style: const TextStyle(
                      color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                Text(
                  "${totalPrice(widget.dishes)}€",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<Item> items = [];
              for (final dish in widget.dishes) {
                final item = Item(dish, false);
                items.add(item);
              }
              Order order = Order(items, widget.table);
              guardaPlatos(order);
              setState(() {
                widget.dishes.clear();
              });
              Navigator.of(context).pop(true);
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
