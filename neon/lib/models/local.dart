import 'package:firebase_database/firebase_database.dart';
import 'package:neon/models/food.dart';

class Local {

  String address;
  String city;
  String imageUrl;
  String name;
  int rating;
  String typeStore;
  String id;

  Local(
      this.address,
      this.city,
      this.imageUrl,
      this.name,
      this.rating,
      this.typeStore,
      this.id
      );

  @override
  String toString() {
 
    return id;
  }

  Local.getLocal(DataSnapshot snap):
        address = snap.value['address'],
        city = snap.value['city'],
        imageUrl = snap.value['imageUrl'] ,
        name = snap.value['name'],
        rating = snap.value['rating'],
        typeStore = snap.value['typeStore'],
        id = snap.key;



}