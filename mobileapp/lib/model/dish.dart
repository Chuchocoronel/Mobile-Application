class Dish {
  String name = "NoName";
  int price = 0;

  Dish(this.name, this.price);

  Dish.fromFirestore(Map<String, dynamic> data)
      : name = data['name'],
        price = data['price'];
}
