import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/models/local.dart';
import 'package:neon/models/product.dart';
import 'package:neon/widgets/product_item.dart';

import 'cart_screen.dart';



class ProductList extends StatefulWidget {
  final Local local;
  ProductList(this.local);

  @override
  _ProductListState createState() => _ProductListState();
}



class _ProductListState extends State<ProductList> {
  List<Product> products = [];
 

  //DatabaseReference reference = FirebaseDatabase.instance.reference().child('product').orderByChild('local').equalTo(idLocal);
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;

 

  @override
  void initState() {
   
    print("********************"+widget.local.id);
//test
    final productReference = FirebaseDatabase.instance
    .reference()
    .child('locales/${widget.local.id}')
    .child('products');
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
      print("estoy en error"+e);
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
        title: new Text(widget.local.name),
         actions: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 5.0, bottom: 5.0, top: 5.0),
                    margin: EdgeInsets.only(right: 5.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.redAccent[200],
                        tooltip: 'Mon panier',
                        isExtended: true,
                        heroTag: "Merci",
                        child: Icon(Icons.shopping_cart,
                            color: Colors.white, size: 30.0),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CartScreen())))),
              ],
            ),
          ],
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
          return ProductItem(products[index],widget.local);
        },
      );
    } else {
      return Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("${widget.local.name} no ha registrado productos"),
          ],
        )
        
        );
    }
  }
}
