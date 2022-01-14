import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/model/order.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  num totalPrice(List<Item> items) {
    num total = 0;
    for (final item in items) {
      total += item.plato.price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection("/Orders");
    bool checkedButton = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders, slide to see more orders"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<List<Order>>(
          stream: ordersSnapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Order>> snapshot,
          ) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return PageView.builder(
              controller: controller,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final items = order.items;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Table Nº ${snapshot.data![index].tableNum.toString()}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          onLongPress: () {
                            final docRef =
                                db.doc("/${snapshot.data![index].id}");
                            docRef.delete();
                          },
                          child: const Text(
                            "Hold to Delete Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, it) {
                            final dish = items[it].plato;
                            if (checkedButton == false) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    checkedButton = true;
                                  });
                                },
                                child: ListTile(
                                  tileColor: Colors.orange,
                                  title: Text(
                                    dish.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: Text(
                                    "${dish.price}€",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (checkedButton == true) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    checkedButton = true;
                                  });
                                },
                                child: ListTile(
                                  tileColor: Colors.black,
                                  title: Text(
                                    dish.name,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: Text(
                                    "${dish.price}€",
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const Card();
                          }),
                    ),
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                              "${totalPrice(items)}€",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
