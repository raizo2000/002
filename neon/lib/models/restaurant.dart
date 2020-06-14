import 'package:firebase_database/firebase_database.dart';
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
 
    return id;
  }

  Restaurant.getRestaurant(DataSnapshot snap):
        address = snap.value['address'],
        city = snap.value['city'],
        imageUrl = snap.value['imageUrl'] ,
        name = snap.value['name'],
        rating = snap.value['rating'],
        typeStore = snap.value['typeStore'],
        id = snap.key;



}