import 'package:flutter/material.dart';
import 'package:mobileapp/screens/dishes_list_screen.dart';

class ChooseTable extends StatefulWidget {
  const ChooseTable({Key? key}) : super(key: key);

  @override
  _ChooseTableState createState() => _ChooseTableState();
}

class _ChooseTableState extends State<ChooseTable> {
  List<num> tables = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 21; i++) {
      tables.add(i);
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
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 10 / 9,
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                var color = Colors.grey.shade300;
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.flatware_outlined,
                            size: 40,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Table",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Nº${tables[index]}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
