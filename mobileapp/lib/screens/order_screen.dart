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
        actions: [
          IconButton(
            icon: const Icon(Icons.shop),
            onPressed: () {
              guardaPlatos(
                "mesa",
                Order([
                  Item(Plato("tortilla", 10, "dish")),
                  Item(Plato("fistro", 1, "dish")),
                ]),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Clear order"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.dishes.length,
              itemBuilder: (context, index) {
                final dish = widget.dishes[index];
                return ListTile(
                  title: Text(dish.name),
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
        ],
      ),
    );
  }
}
