import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileapp/model/platos.dart';

class Item {
  Plato plato;
  Item(this.plato);

  Item.fromJson(Map<String, dynamic> json)
      : plato = Plato.fromFirestore(json['plato']);

  Map<String, dynamic> toFirestore() => {
        'plato': plato.toFirestore(),
      };
}

class Order {
  List<Item> items;
  String id = "";

  Order(this.items);

  Order.fromFirebase(Map<String, dynamic> json)
      : items = json['items']
            .map((item) => Item.fromJson(item))
            .toList()
            .cast<Item>();

  Map<String, dynamic> toFirestore() => {
        'items': items.map((item) => item.toFirestore()).toList(),
      };
}

Stream<List<Order>> ordersSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Orders").snapshots();
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
