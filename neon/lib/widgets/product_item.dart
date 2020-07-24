import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/food.dart';
import 'package:neon/models/local.dart';
import 'package:neon/models/order.dart';
import 'package:neon/models/product.dart';
import 'package:neon/models/restaurant.dart';
import 'package:toast/toast.dart';

class ProductItem extends StatelessWidget {
  final Product _productItem;
  final Local nameLocal;
  const ProductItem(this._productItem, this.nameLocal);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: _productItem.productImage,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
        /* Expanded(
            flex: 5,
            child: Image.network(
              _productItem.productImage,
              fit: BoxFit.fitWidth,
            )),*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _productItem.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        Text("\$" + _productItem.price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline),
        RawMaterialButton(
          child: _productItem.estado != 0
              ? Text(
                  'Agregar al Carrito'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Theme.of(context).primaryColor),
                )
              : Text(
                  'Producto Agotado'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.grey),
                ),
          onPressed: () {
            if (_productItem.estado != 0) {
              List<Food> listProd = new List<Food>();
              Food menuItem = new Food(_productItem.productImage,
                  _productItem.name, _productItem.price);
              listProd.add(menuItem);
              Restaurant localAux = Restaurant(
                  nameLocal.address,
                  nameLocal.city,
                  nameLocal.imageUrl,
                  listProd,
                  nameLocal.name,
                  nameLocal.rating,
                  nameLocal.typeStore,
                  nameLocal.id);
              currentUser.cart.add(new Order(
                  food: menuItem,
                  quantity: 1,
                  restaurant: localAux,
                  date: DateTime.now().toString()));

              Toast.show("Producto agregado al carrito!!", context,
                  duration: Toast.LENGTH_LONG);
            }
          },
        )
      ],
    ));
  }
}
