import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileapp/model/dish.dart';

class Restaurant {
  String name;
  List<Dish> dishes;

  Restaurant(this.name, this.dishes);
}

Stream<List<Restaurant>> restaurantsSnapshots() {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/Restaurantes").snapshots();
  return stream.map((querySnapshot) {
    List<Restaurant> restaurants = [];
    for (final docRef in querySnapshot.docs) {
      List<Dish> dishes = [];
      final dishStream = docRef.reference
          .collection("${docRef.reference.path}/Platos")
          .snapshots();
      dishStream.map((qDishSnapshot) {
        for (final dishDocRef in qDishSnapshot.docs) {
          dishes.add(Dish.fromFirestore(dishDocRef.data()));
        }
      });

      restaurants.add(Restaurant(docRef.id, dishes));
    }
    return restaurants;
  });
}
