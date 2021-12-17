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

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection("/Orders");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
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
                final items = snapshot.data![index].items;
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      onLongPress: () {
                        final docRef = db.doc("/${snapshot.data![index].id}");
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, it) {
                          final dish = items[it].plato;
                          return ListTile(
                            title: Text(
                              dish.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              "${dish.price}€",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Total:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              "0€",
                              style: TextStyle(
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
