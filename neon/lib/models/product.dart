import 'package:firebase_database/firebase_database.dart';

class Product {
  String _id;
  String _name;
  // String _codebar;
  String _description;
  double _price;
  int _estado;
  String _productImage;

  Product(
      this._id,
      this._name,
      //this._codebar,
      this._description,
      this._price,
      //this._stock,
      this._productImage);

  Product.map(dynamic obj) {
    this._name = obj['name'];
    //this._codebar = obj['codebar'];
    this._description = obj['description'];
    this._price = double.parse(obj['price']);
    this._estado = obj['estado'];
    this._productImage = obj['ProductImage'];
  }

  String get id => _id;
  String get name => _name;
  // String get codebar => _codebar;
  String get description => _description;
  double get price => _price;
  int get estado => _estado;
  String get productImage => _productImage;

  Product.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    // _codebar = snapshot.value['codebar'];
    _description = snapshot.value['description'];
    _price = double.parse(snapshot.value['price']);
    _estado = snapshot.value['stock'];
    _productImage = snapshot.value['ProductImage'];
  }
}
