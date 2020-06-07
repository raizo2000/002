import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:neon/data/data.dart';
import 'package:neon/models/order.dart';

class OrderScreen extends StatelessWidget {
  double totalPrice = 0;
  String name,numero,direccion;
  OrderScreen({Key key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Mi Pedido'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/items/delivery.jpg'),
                    )
                ),
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
                            boxShadow:[
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                  offset: Offset(0,10)
                              )
                            ]
                        ),

                        child: Column(
                            children: <Widget>[
                              Container(


                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nombre",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  validator:(value){
                                  return value.isEmpty ? "Nombre Requerido":null;
                                  },
                                  onSaved: (value){
                                    return name = value;
                                  },
                                ),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Número",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  validator:(value){
                                    return value.isEmpty ? "Número Requerido":null;
                                  },
                                  onSaved: (value){
                                    return numero = value;
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Dirección",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  validator:(value){
                                    return value.isEmpty ? "Direccion Requerido":null;
                                  },
                                  onSaved: (value){
                                    return direccion = value;
                                  },
                                ),
                              ),
                            ]
                        )
                    )
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
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text(
                        'Aceptar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        )
                    ),
                    onPressed: () {

                      saveToDatabase();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text(
                        'Cancelar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        )
                    ),
                    onPressed: () {},
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
                  child:Scrollbar(
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

                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                          ),),
                        Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700]
                            )
                        ),
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
  _llenarResumen(){
    String resumen="Ha solicitado:\n";
    for(int i = 0; i<currentUser.cart.length;i++){


        resumen +=currentUser.cart[i].quantity.toString() +" Plato de: "+ currentUser.cart[i].food.name+" con el precio de: \$"+currentUser.cart[i].food.price.toString()+" Dolares\n";

    }
    return resumen;
  }
  bool validateAndSave(){

  }
  void saveToDatabase() async{
    var  detalle;
    var   data;
    DatabaseReference ref  = FirebaseDatabase.instance.reference();
   for(int i = 0; i<currentUser.cart.length;i++){
       detalle =[{
       "cantidad":currentUser.cart[i].quantity,
       "name": currentUser.cart[i].food.name,
       "precio":currentUser.cart[i].food.price,
       "restaurante":currentUser.cart[i].restaurant.id

     }];
       data = {
         "detalle":[detalle,],
         "direccion": direccion,
         "name": name,
         "numero": numero,
         "precioPagar": totalPrice.toStringAsFixed(2)
       };

     };

    ref.child("Pedido").push().set(data);
    print("Intente guardar");
  }
}
