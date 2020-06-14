

import 'package:flutter/material.dart';
import 'package:neon/screens/home_screen.dart';



class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.canPop(context);
        },
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