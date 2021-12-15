import 'package:flutter/material.dart';
import 'package:mobileapp/model/order.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
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
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 16 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {},
                  child: GridTile(
                    child: Container(
                      color: Colors.yellow[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
