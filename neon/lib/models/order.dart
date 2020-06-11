import 'package:neon/models/food.dart';
import 'package:neon/models/restaurant.dart';

class Order {
  String nameApplicant;
  String numberApplicant;
  String addressApplcant;
  final Restaurant restaurant;
  final Food food;
  int quantity;
  final String date;

  Order({
    this.restaurant,
    this.food,
    this.date,
    this.quantity
  });
}