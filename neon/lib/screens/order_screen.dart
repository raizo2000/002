import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/order.dart';

double totalPrice = 0;
String name, numero, direccion;

class OrderScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    currentUser.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Mi Pedido'),
        backgroundColor: Colors.blueAccent,
      ),
      body: MyCustomForm(),
    );
  }

  _llenarResumen() {
    String resumen = "Ha solicitado:\n";
    for (int i = 0; i < currentUser.cart.length; i++) {
      resumen += "En la ciudad de: \n${currentUser.cart[i].restaurant.city}\n";
      resumen += currentUser.cart[i].quantity.toString() +
          " Pedido de : " +
          currentUser.cart[i].food.name +
          " con el precio de: \$" +
          currentUser.cart[i].food.price.toString() +
          " Dolares\n";
    }
    return resumen;
  }

  bool validateAndSave() {}
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/items/delivery.jpg'),
                )),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nombre",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Nombre Requerido"
                                    : null;
                              },
                              onSaved: (value) {
                                return name = value;
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Número:Ejemplo 0987654321",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                return value.isEmpty || value.length > 10
                                    ? "Numero Incorrecto"
                                    : null;
                              },
                              onSaved: (value) {
                                return numero = value;
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Dirección",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Direccion Requerido"
                                    : null;
                              },
                              onSaved: (value) {
                                return direccion = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Nota: Una vez realizado el Pedido se le realizara una llamada en unos minutos, para confirmar el mismo.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Aceptar',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // Si el formulario es válido, queremos mostrar un Snackbar
                        if (currentUser.cart.length > 0) {
                          // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Procesando Pedido')));
                          // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Pedido Registrado Exitosamente')));
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Su Orden se ha solicitado Exitosamente!!!')));
                          Future.delayed(const Duration(milliseconds: 1500),
                              () {
                            saveToDatabase();

                            currentUser.cart.clear();
                            totalPrice = 0.0;

                            setState(() {
                              // Here you can write your code for open new view

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                              //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('Pedido Registrado Exitosamente')));
                            });
                          });
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('No tienes Productos en el Carrito')));
                          Future.delayed(const Duration(milliseconds: 1500),
                              () {
                            currentUser.cart.clear();
                            totalPrice = 0.0;

                            setState(() {
                              // Here you can write your code for open new view

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                              //
                            });
                          });
                        }
                      }

                      // Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Cancelar',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    onPressed: () {
                      currentUser.cart.clear();
                      totalPrice = 0.0;

                      setState(() {
                        // Here you can write your code for open new view

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                        //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('Pedido Registrado Exitosamente')));
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Resumen de Pedido:',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.02),
                child: Container(
                  //height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.grey[200],
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  child: Scrollbar(
                    child: Text(
                      _llenarResumen(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 1.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        Text('\$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700])),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _llenarResumen() {
    String resumen = "Ha solicitado:\n";
    for (int i = 0; i < currentUser.cart.length; i++) {
      resumen += "En la ciudad de: \n${currentUser.cart[i].restaurant.city}\n";
      resumen += currentUser.cart[i].quantity.toString() +
          " Pedido de : " +
          currentUser.cart[i].food.name +
          " con el precio de: \$" +
          currentUser.cart[i].food.price.toString() +
          " Dolares\n";
    }
    return resumen;
  }

  void saveToDatabase() async {
    var data;
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    /// var uuid = Uuid().v4();
    data = {
      "detalle": [
        for (int i = 0; i < currentUser.cart.length; i++)
          {
            "cantidad": currentUser.cart[i].quantity,
            "name": currentUser.cart[i].food.name,
            "precio": currentUser.cart[i].food.price,
            "Ciudad": currentUser.cart[i].restaurant.city,
            "restaurante": currentUser.cart[i].restaurant.name
          }
      ],
      "direccion": addressController.text,
      "name": nameController.text,
      "numero": numberController.text,
      "estado": -1,
      "precioPagar": totalPrice.toStringAsFixed(2)
    };

    var refnuevo = ref.child("Pedido").push();
    refnuevo.set(data);
    String id = refnuevo.key;
    print("Pedido/$id/detalle");
  }
}
