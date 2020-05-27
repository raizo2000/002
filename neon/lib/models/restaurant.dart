import 'package:neon/models/food.dart';

class Restaurant {
  final String name;
  final String imageUrl;
  final String address;
  final int rating;
  final List<Food> menu;
  //tipo
  //ciudad

  Restaurant({
    this.imageUrl,
    this.name,
    this.address,
    this.rating,
    this.menu
  });
}