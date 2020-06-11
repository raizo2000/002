import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/order.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:neon/models/user.dart';

import 'order_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  double total;
  final items = List<String>.generate(3, (i) => "Item ${i + 1}");
  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 170.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child:  Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:NetworkImage(order.food.imageUrl),
                            fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.food.name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            order.restaurant.name,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 0.8,
                                      color: Colors.black54
                                  )
                              ),
                              child: Container(
                                  padding: new EdgeInsets.all(4.0),
                                  child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (order.quantity > 1) {
                                              setState(() {
                                                order.quantity--;
                                              });
                                            }
                                          },child: Text(
                                          '-',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        ),
                                        SizedBox(width: 20.0),
                                        Text(
                                          '${order.quantity.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (order.quantity < 10) {
                                                order.quantity++;
                                              }
                                            });
                                          },child: Text(
                                          '+',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        ),
                                      ]
                                  )
                              )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          Container(
            //  margin: EdgeInsets.all(3.0),
            child: Text(
                '\$${order.quantity * order.food.price}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                )
            ),
          )
        ],
      ),
    );
  }

  _listOrden(){

  }

  @override
  Widget build(BuildContext context) {

    double totalPrice = 0.0;

    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);

    return new Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito (${currentUser.cart.length})'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];

          return _buildCartItem(order);

          }
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 7.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),),
                    Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700]
                        )
                    ),
                  ],
                ),
                SizedBox(height: 80.0)
              ],
            ),
          );


        }, separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.green,
        );
      },
      ),
      bottomSheet: Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -1),
                  blurRadius: 6.0
              )
            ]
        ),
        child: Center(
          child: FlatButton(
            child: Text(
                'Aceptar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0
                )
            ),
            onPressed: () {
              Navigator.push(context,new MaterialPageRoute(
                  builder: (BuildContext context)=> new OrderScreen())
              );
            },
          ),
        ),
      ),
    );
  }
}