import 'package:flutter/material.dart';
import 'package:mobileapp/model/order.dart';
import 'package:mobileapp/screens/dishes_list_screen.dart';

class ChooseTable extends StatefulWidget {
  const ChooseTable({Key? key}) : super(key: key);

  @override
  _ChooseTableState createState() => _ChooseTableState();
}

class _ChooseTableState extends State<ChooseTable> {
  List<String> tables = [];
  List<num> tableOrder = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      tables.add("Table Nº$i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a table"),
      ),
      body: Row(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 9 / 14,
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                tableOrder = tableWithOrder();

                var color = Colors.grey.shade300;
                for (final number in tableOrder) {
                  if (number == index + 1) {
                    color = Colors.blue;
                  }
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DishesListScreen(
                        table: index + 1,
                      ),
                    ));
                  },
                  child: GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.event_seat_rounded,
                            size: 40,
                          ),
                          Text(
                            tables[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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
