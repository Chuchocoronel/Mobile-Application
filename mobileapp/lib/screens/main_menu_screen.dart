import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/dishes_list_screen.dart';
import 'package:mobileapp/screens/orders_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DishesListScreen(),
              ));
            },
            child: const Text("Customer Service"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrdersListScreen(),
              ));
            },
            child: const Text("Kitchen orders"),
          ),
        ),
      ],
    );
  }
}
