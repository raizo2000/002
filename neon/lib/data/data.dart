import 'package:neon/models/food.dart';
import 'package:neon/models/order.dart';
import 'package:neon/models/restaurant.dart';
import 'package:neon/models/user.dart';


// Food

Food  _burrito = new Food('assets/images/burrito.jpg', 'Burrito',  8.99);


Restaurant _restaurant2 = new  Restaurant('Av.Amazonas','quito','assets/images/restaurant2.jpg',[_burrito],'kfc',4,'Comidas','8');



// User
final currentUser = User(
  name: 'Administrador',

  cart: [
    Order(
      date: 'Nov 11, 2019',
      food: _burrito,
      restaurant: _restaurant2,
      quantity: 2,
    ),

  ],
);