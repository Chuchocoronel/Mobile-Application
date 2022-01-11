import 'package:cloud_firestore/cloud_firestore.dart';

class Plato {
  String name;
  num price;
  String type;

  Plato(this.name, this.price, this.type);
  Plato.fromFirestore(Map<String, dynamic> data)
      : name = data['name'],
        price = data['price'],
        type = data['type'];

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'price': price,
        'type': type,
      };
}

Stream<Map<String, List<Plato>>> platosSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Platos").orderBy("type").snapshots();
  return stream.map((querySnapshot) {
    Map<String, List<Plato>> dishes = {};
    for (final docRef in querySnapshot.docs) {
      final plato = Plato.fromFirestore(docRef.data());
      if (!dishes.containsKey(plato.type)) {
        dishes[plato.type] = [];
      }
      dishes[plato.type]!.add(plato);
    }
    return dishes;
  });
}
