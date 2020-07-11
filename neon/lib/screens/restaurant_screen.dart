import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/food.dart';
import 'package:neon/models/order.dart';
import 'package:neon/models/restaurant.dart';
import 'package:neon/widgets/rating_starts.dart';

class RestaurantScreen extends StatefulWidget {

  final Restaurant restaurant;

  RestaurantScreen({this.restaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _buildMenuItem(Food menuItem) {

    double taille = MediaQuery.of(context).size.width / 2.25;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: taille,
            width: taille,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(menuItem.imageUrl),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          Container(
            height:taille,
            width: taille,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black87.withOpacity(0.3),
                    Colors.black54.withOpacity(0.3),
                    Colors.black38.withOpacity(0.3),
                  ],
                  stops: [0.1, 0.4, 0.6, 0.9],
                )
            ),
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: <Widget>[
                Text(
                    menuItem.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2
                    ),
                ),
                Text(
                    '\$${menuItem.price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2
                    )
                )
              ],
            ),
          ),
          Positioned(
              bottom: 10.0,
              right: 10.0,
              child: Container(
                width: 48.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                  
                    currentUser.cart.add(
                        new Order(food: menuItem, quantity: 1, restaurant: widget.restaurant, date: DateTime.now().toString())
                    );
                    _snack(menuItem);
                  },
                ),
              )
          )
        ],
      ),
    );
  }

  _snack(Food menuItem) {
    SnackBar snackBar = new SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content:Text(
        '${menuItem.name} ha sido agregado a tu carro',
        style: TextStyle(
            fontWeight: FontWeight.w600
        ),
      ),
      elevation: 1.0,
      action: SnackBarAction(
        label: "Anular",
        textColor: Colors.white,
        onPressed: () {
          currentUser.cart.removeAt(currentUser.cart.length-1);
        },

      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                  tag: widget.restaurant.name,
                  child:  Image.network(
                    widget.restaurant.imageUrl,
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,

                  )
              ) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () {Navigator.pop(context);},
                    ),
                    /*IconButton(
                      icon: Icon(Icons.restaurant),
                      color: Colors.white,
                      iconSize: 50.0,
                      onPressed: () {},
                    )*/
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        widget.restaurant.name,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    Text(
                        widget.restaurant.city,
                        style: TextStyle(
                          fontSize: 18.0,
                        )
                    )
                  ],
                ),
                RatingStarts(rating: widget.restaurant.rating, taille: 35.0,),
                SizedBox(height: 6.0,),
                Text(
                    widget.restaurant.address,
                    style: TextStyle(
                        fontSize: 15.0
                    )
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Descripcion.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
                'Menu',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2
                )
            ),
          ),
          SizedBox(height: 10.0,),
          Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(10.0),
                crossAxisCount: 2,
                //  crossAxisSpacing: 15.0,
                children: List.generate(widget.restaurant.menu.length, (index) {
                  Food food = widget.restaurant.menu[index];
                  return _buildMenuItem(food);
                }),
              )
          ),
        ],
      ),
    );
  }
}