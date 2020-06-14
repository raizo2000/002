import 'package:firebase_database/firebase_database.dart';

class Food {
    String imageUrl;
    String name;
   double price;

  Food(
    this.imageUrl,
    this.name,
    this.price
  );
  @override
  String toString() {

    //return super.toString();
    return (this.name + ""+this.price.toString());
  }
  Food.getFood(DataSnapshot snap ):
        imageUrl = snap.value['imageUrl'],
    name = snap.value['name'],
    price = snap.value['price'];
}