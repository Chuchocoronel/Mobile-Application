import 'package:cloud_firestore/cloud_firestore.dart';

class Plato {
  String name;
  int price;
  String type;

  Plato(this.name, this.price, this.type);
  Plato.fromFirestore(Map<String, dynamic> data)
      : name = data['name'],
        price = data['price'],
        type = data['type'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'type': type,
      };
}

Stream<List<Plato>> platosSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Platos").snapshots();
  return stream.map((querySnapshot) {
    List<Plato> dishes = [];
    for (final docRef in querySnapshot.docs) {
      dishes.add(Plato.fromFirestore(docRef.data()));
    }
    return dishes;
  });
}
