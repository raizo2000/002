import 'package:flutter/material.dart';
import 'package:neon/models/order.dart';

class OrderScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Mi Pedido'),
      ),
      body: SingleChildScrollView(
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
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nombre",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Numero",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Dirección",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
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
                    'Nota: Una vez realizado el Pedido se le realizara en unos minutos, una llamada para confirmar el mismo.',
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
                    onPressed: () {},
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
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  child: Text(
                        'Cafe 1 la cafeteria '
                        'Bielita 6 la cerveceria'
                        'Chaulafan 1 el chino'
                        'Pastel 1 Panaderia Rosita'
                        'Papitas 1 Rufles'
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
                            '120',
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
}
