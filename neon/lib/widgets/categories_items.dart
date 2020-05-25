import 'package:flutter/material.dart';

class CategoriesItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'assets/items/desechable.png',
            image_caption: 'Comida',
          ),
          Category(
            image_location: 'assets/items/rapida.png',
            image_caption: 'Rapida',
          ),
          Category(
            image_location: 'assets/items/pizza.png',
            image_caption: 'Pizzeria',
          ),
          Category(
            image_location: 'assets/items/pan.png',
            image_caption: 'Panaderia',
          ),
          Category(
            image_location: 'assets/items/panaderia.png',
            image_caption: 'Pasteleria',
          ),
          Category(
            image_location: 'assets/items/dulces.png',
            image_caption: 'Dulceria',
          ),
          Category(
            image_location: 'assets/items/biela.png',
            image_caption: 'Bebidas',
          ),
          Category(
            image_location: 'assets/items/cocinar.png',
            image_caption: 'Agachaditos',
          ),
          Category(
            image_location: 'assets/items/jugos.png',
            image_caption: 'Jugos',
          ),
          Category(
            image_location: 'assets/items/cafe.png',
            image_caption: 'Cafeteria',
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 80.0,
                height: 60.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption, style: new TextStyle(fontSize: 12.0),),
              )
          ),
        ),
      ),
    );
  }
}