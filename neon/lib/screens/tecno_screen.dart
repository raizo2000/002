import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/models/local.dart';
import 'package:neon/screens/product_screen.dart';
import 'package:neon/widgets/anuncio_widget.dart';
import 'package:neon/widgets/drawer.dart';
import 'package:neon/widgets/slider.dart';
//import 'package:toast/toast.dart';

import 'cart_screen.dart';


class TecnoScreen extends StatefulWidget {
   final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String categoria;
  TecnoScreen(this.categoria,this.auth,this.onSignedOut);
  @override
  _TecnoScreenState createState() => _TecnoScreenState();
}

class _TecnoScreenState extends State<TecnoScreen> {
  
String city;
  List<String> cityList = [];
  List<Local> locales=[];
  List<Local> auxLocalList = [];
  List<Local> filteredLocalList = [];
  var localReference;
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;

  @override
  void initState() {
    city = "Mejia";
    
    _fillCity();
    localReference = FirebaseDatabase.instance
        .reference()
        .child('locales')
        .orderByChild('Categoria')
        .equalTo(widget.categoria);
    print(widget.categoria);
    super.initState();
    
    onAddedSubs = localReference.onChildAdded.listen(_onProductAdded);
    onChangeSubs = localReference.onChildChanged.listen(_onProductUpdate);
    _searchCity(city);
   
  }

  @override
  void dispose() {
    super.dispose();
    onAddedSubs.cancel();
    onChangeSubs.cancel();
 
  }

  bool _validaCity(var ciudad) {
    if (ciudad == city) {
      return true;
    } else {
      return false;
    }
  }

  void _onProductAdded(Event event) {
    if (_validaCity(event.snapshot.value['city'])) {
      try {
        setState(() {
          print(event.snapshot.value);
          locales.add(new Local.getLocal(event.snapshot));

          print("linea 69: Tengo:" + locales.length.toString());
        });
      } catch (e) {
        print("estoy en error");
      }
    } else {
      // local.clear();
      print("linea 75: Entre al else:" + locales.length.toString());
    }
  }

  void _onProductUpdate(Event event) {
    if (_validaCity(event.snapshot.value['city'])) {
      var oldProductValue =
          locales.singleWhere((product) => product.id == event.snapshot.key);
      setState(() {
        locales[locales.indexOf(oldProductValue)] =
            new Local.getLocal(event.snapshot);
      });
    }
  }

  _searchCity(String city) {
    
    localReference.once().then((DataSnapshot snap) {
      if (snap.value != null) {
        var keysr = snap.value.keys;
        var data = snap.value;

        filteredLocalList.clear();
        for (var individualKey in keysr) {
          if (data[individualKey]['city'] == city) {
            Local rest = Local(
                data[individualKey]['address'],
                data[individualKey]['city'],
                data[individualKey]['imageUrl'],
                data[individualKey]['name'],
                data[individualKey]['rating'],
                data[individualKey]['Categoria'],
                individualKey);

            // print('name: $data[individualKey]["name"]');
            filteredLocalList.add(rest);
            _cambiarState();
          } else {
            print("entre al else linea 135 y soy " + individualKey);
          }
        }
        setState(() {});
      } else {
        print("No exite restauranes");
        filteredLocalList.clear();
        _cambiarState();
      }
    });
  }

  _cambiarState() {
    setState(() {
      locales = filteredLocalList;
      auxLocalList = filteredLocalList;
    });
  }

  final List<String> imgList = [
    //'https://firebasestorage.googleapis.com/v0/b/neonapp-c1dbb.appspot.com/o/local%2FCompuMundo%2Fimage45.jpeg?alt=media&token=1caa8f50-41a7-4a1b-a192-e94a1342ec26',
    /*'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQP7OLC-utKoCt9_V3mcV-S02NNu_Px-sFj1w&usqp=CAUs',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  */
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(widget.auth,widget.onSignedOut),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: CustomScrollView(
            // Agregue la barra de aplicaciones y la lista de elementos como astillas en los siguientes pasos.
            slivers: <Widget>[
              SliverAppBar(
                //Provide a standard title.
                // title: Text('Tecnología'),
                // pinned: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CartScreen())),
                  )
                ],
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                // floating: true,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: HomeSlider(widget.categoria),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 200,
              ),
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/banner-1.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AnuncioWidget(),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text('Nuestros Establecimientos Asociados',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          padding: EdgeInsets.only(
                              top: 8, left: 6, right: 6, bottom: 12),
                          children: List.generate(locales.length, (index) {
                            return Container(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProductList(locales[index]),
                                    ));

                                    print('Card tapped. ' + index.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                70,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: locales[index].imageUrl,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                      ),
                                      ListTile(
                                          title: Text(
                                        locales[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  // Builds 1000 ListTiles
                  childCount: 1,
                ),
              )
            ]),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(() {
            _settingModalBottomSheet(context);
          });
        },
        child: new Icon(
          Icons.location_city,
          color: Colors.white,
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    _fillCity();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Wrap(
                    children: <Widget>[
                      new ListTile(
                          leading: new Icon(
                            Icons.opacity,
                            color: Colors.redAccent,
                          ),
                          title: new Text(cityList[index]),
                          onTap: () => {
                                print(cityList[index]),
                                city = cityList[index],
                                _searchCity(cityList[index]),
                                //  restauranteList = filteredRestauranteList,
                                Navigator.pop(context)
                              }),
                    ],
                  ),
                );
              });
        });
  }
// _mensajeInicial(){
//     Toast.show("Bienvenido, estas tiendas son de la ciudad de $city", context,
//                   duration: Toast.LENGTH_LONG, textColor: Colors.white , backgroundColor: Colors.redAccent );
// }
  _fillCity() {
    List<String> tempCity = [];
    DatabaseReference cityRef =
        FirebaseDatabase.instance.reference().child("Ciudad");
    cityRef.once().then((DataSnapshot snap) {
      var keysr = snap.value.keys;
      var data = snap.value;

      cityList.clear();
      for (var individualKey in keysr) {
        tempCity.add(data[individualKey]['name']);
      }

      setState(() {
        cityList = tempCity;
      });
    });
  }
}
