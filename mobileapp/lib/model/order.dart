import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileapp/model/platos.dart';

class Item {
  Plato plato;
  bool check;

  Item(this.plato, this.check);

  void toggleCheck() => check = !check;

  Item.fromJson(Map<String, dynamic> json)
      : plato = Plato.fromFirestore(json['plato']),
        check = json['check'];

  Map<String, dynamic> toFirestore() => {
        'plato': plato.toFirestore(),
        'check': check,
      };
}

class Order {
  List<Item> items;
  num tableNum;
  String id = "";

  Order(this.items, this.tableNum);

  Order.fromFirebase(Map<String, dynamic> json)
      : tableNum = json['table'],
        items = json['items']
            .map((item) => Item.fromJson(item))
            .toList()
            .cast<Item>();

  Map<String, dynamic> toFirestore() => {
        'table': tableNum.toInt(),
        'items': items.map((item) => item.toFirestore()).toList(),
      };
}

Stream<List<Order>> ordersSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Orders").orderBy("table").snapshots();
  return stream.map((querySnapshot) {
    List<Order> orders = [];
    for (final docRef in querySnapshot.docs) {
      final order = Order.fromFirebase(docRef.data());
      order.id = docRef.id;
      orders.add(order);
    }
    return orders;
  });
}

List<num> tableWithOrder() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Orders").orderBy('table').snapshots();
  List<num> tables = [];
  stream.map((querySnapshot) {
    for (final docRef in querySnapshot.docs) {
      final order = Order.fromFirebase(docRef.data());
      tables.add(order.tableNum);
    }
  });
  return tables;
}

Stream<List<Order>> sortedOrdersSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Orders").orderBy("table").snapshots();
  return stream.map((querysnap) {
    List<Order> orders = [];
    for (final docsnap in querysnap.docs) {
      orders.add(Order.fromFirebase(docsnap.data()));
    }
    return orders;
  });
}

Future<void> guardaPlatos(Order order) async {
  final db = FirebaseFirestore.instance;
  await db
      .collection("/Orders")
      .withConverter<Order>(
        fromFirestore: (snapshot, _) => Order.fromFirebase(snapshot.data()!),
        toFirestore: (model, _) => model.toFirestore(),
      )
      .add(order);
}

Future<void> toggleCheckItem(Order order, int itemIndex) async {
  order.items[itemIndex].toggleCheck();
  final db = FirebaseFirestore.instance;
  await db.doc("/Orders/${order.id}").update({
    'items': order.items.map((e) => e.toFirestore()).toList(),
  });
}
