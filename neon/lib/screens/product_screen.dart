import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/models/product.dart';
import 'package:neon/widgets/product_item.dart';

String idLocal;

class ProductList extends StatefulWidget {
  final String idLocal;
  final String nameLocal;
  ProductList(this.idLocal, this.nameLocal);

  @override
  _ProductListState createState() => _ProductListState();
}

final productReference = FirebaseDatabase.instance
    .reference()
    .child('product')
    .orderByChild('local')
    .equalTo(idLocal);

class _ProductListState extends State<ProductList> {
  List<Product> products = new List();

  //DatabaseReference reference = FirebaseDatabase.instance.reference().child('product').orderByChild('local').equalTo(idLocal);
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;

  @override
  void initState() {
    idLocal = widget.idLocal;
    super.initState();

    onAddedSubs = productReference.onChildAdded.listen(_onProductAdded);
    onChangeSubs = productReference.onChildChanged.listen(_onProductUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    onAddedSubs.cancel();
    onChangeSubs.cancel();
  }

  void _onProductAdded(Event event) {
    try {
      setState(() {
        products.add(new Product.fromSnapShot(event.snapshot));
        print(products.length);
      });
    } catch (e) {
      print("estoy en error");
    }
  }

  void _onProductUpdate(Event event) {
    var oldProductValue =
        products.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      products[products.indexOf(oldProductValue)] =
          new Product.fromSnapShot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.nameLocal),
      ),
      body: _listarProductos(),
    );
  }

  _listarProductos() {
    print("Tengo" + products.length.toString());
    if (products.length != 0) {
      return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250.0, childAspectRatio: 0.58),
        itemBuilder: (context, index) {
          print("Soy no nulo");
          return ProductItem(products[index]);
        },
      );
    } else {
      return Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("${widget.nameLocal} no ha registrado productos"),
          ],
        )
        
        );
    }
  }
}