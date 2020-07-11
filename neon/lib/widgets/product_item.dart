import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/product.dart';
import 'package:toast/toast.dart';

class ProductItem extends StatelessWidget {
  final Product _productItem;

  const ProductItem(this._productItem);

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
        Text("\$"+_productItem.price.toString(),
            style: Theme.of(context).textTheme.headline),
        RawMaterialButton(
          child: Text(
            'Agregar al Carrito'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          onPressed: (){ Toast.show(
              "Carrito disponible para version premium!!", context,
              duration: Toast.LENGTH_SHORT);
              },
        )
      ],
    ));
  }
}
