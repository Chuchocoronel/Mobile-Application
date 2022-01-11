import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/orders_list_screen.dart';
import 'package:mobileapp/screens/table_selector.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.yellow,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChooseTable(),
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Create Order",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "View Orders",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
