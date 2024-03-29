import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarts extends StatelessWidget {

  final int rating;
  final double taille;

  RatingStarts({this.rating, this.taille});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  RatingBar(
        initialRating: this.rating.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: taille,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}