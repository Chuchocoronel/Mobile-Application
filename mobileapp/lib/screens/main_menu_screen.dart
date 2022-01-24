import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/orders_list_screen.dart';
import 'package:mobileapp/screens/table_selector.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Column(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Log\nOut",
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Icon(
                          Icons.logout_sharp,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[800],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChooseTable(),
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Icon(
                          Icons.task,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue[800],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OrdersListScreen(),
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Icon(
                          Icons.storage_outlined,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
