import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/items/delivery.jpg'),
                )
              )
            ),
            Container(
              padding: EdgeInsets.all(18.0),
              child: Text(
                  'Mi Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),


          ],
        ),
      )
    );
  }
}