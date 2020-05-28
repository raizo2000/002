import 'package:neon/models/food.dart';

class Restaurant {
  String address;
  String city;
  String imageUrl;
  List<Food> menu;
  String name;
  int rating;
  String typeStore;
  String id;

  Restaurant(
      this.address,
      this.city,
      this.imageUrl,
      this.menu,
      this.name,
      this.rating,
      this.typeStore,
      this.id
      );

  @override
  String toString() {
    // TODO: implement toString
    return id;
  }

}