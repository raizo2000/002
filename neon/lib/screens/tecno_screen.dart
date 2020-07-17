import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neon/models/local.dart';
import 'package:neon/screens/product_screen.dart';
import 'package:neon/widgets/drawer.dart';
import 'package:neon/widgets/slider.dart';
import 'package:toast/toast.dart';

import 'cart_screen.dart';

String categoria;
String city;
class TecnoScreen extends StatefulWidget {
  final String categoria;
  TecnoScreen(this.categoria);
  @override
  _TecnoScreenState createState() => _TecnoScreenState();
}
final localReference = FirebaseDatabase.instance
    .reference()
    .child('locales')
    .orderByChild('Categoria')
    .equalTo(categoria);
class _TecnoScreenState extends State<TecnoScreen> {

DatabaseReference restRef =
      FirebaseDatabase.instance.reference().child("locales");
  List<String> cityList = [];
  List<String> idList = [];
  List<Local> local = new List();
  List<Local> auxLocalList = [];
  List<Local> filteredLocalList = [];

StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;

 @override
  void initState() {
    city = "Latacunga";
    _fillCity();
    categoria = widget.categoria;
    print(categoria);
    super.initState();
    _searchCity(city);
    onAddedSubs = localReference.onChildAdded.listen(_onProductAdded);
    onChangeSubs = localReference.onChildChanged.listen(_onProductUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    onAddedSubs.cancel();
    onChangeSubs.cancel();
  }
 bool _validaCity(var ciudad){
   if(ciudad == city){
    return true;
   }else{
     return false;
   }
 }
  void _onProductAdded(Event event) {
    if(_validaCity(event.snapshot.value['city'])){
      try {
      setState(() {
        print(event.snapshot);
        local.add(new Local.getLocal(event.snapshot));
       
        print(local.length);
      });
    } catch (e) {
      print("estoy en error");
    }
    }
    
  }

  void _onProductUpdate(Event event) {
  if(_validaCity(event.snapshot.value['city'])){
      var oldProductValue =
        local.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      local[local.indexOf(oldProductValue)] =
          new Local.getLocal(event.snapshot);

    });
  }
  }

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
  _searchCity(String city) {
   /*  filteredLocalList.clear();
    for(int i =0 ; i<local.length; i++){
      
    var aux = auxLocalList.singleWhere((local) => local.city==city);
    print(aux);
   filteredLocalList.add(aux);
    }
    _cambiarState();*/
    //restRef.orderByChild("city").equalTo(city).once().then((DataSnapshot snap) {
       localReference.once().then((DataSnapshot snap) {
      //localReference.equalTo(city).once().then((DataSnapshot snap) {
      if (snap.value != null) {
        var keysr = snap.value.keys;
        var data = snap.value;

        filteredLocalList.clear();
        for (var individualKey in keysr) {
          if(data[individualKey]['city']==city){
            idList.add(individualKey);

          Local rest = Local(
              data[individualKey]['address'],
              data[individualKey]['city'],
              data[individualKey]['imageUrl'],
              data[individualKey]['name'],
              data[individualKey]['rating'],
              data[individualKey]['Categoria'],
              individualKey);

          print("idList=$idList.length");
          // print('name: $data[individualKey]["name"]');
          filteredLocalList.add(rest);
          _cambiarState();
          }
        }
        setState(() {
          
        });
      } else {
        print("No exite restauranes");
        filteredLocalList.clear();
        _cambiarState();
      }
    });
  }
 _cambiarState() {
    setState(() {
      local = filteredLocalList;
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
        child: AppDrawer(),
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
                flexibleSpace: HomeSlider(),
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
                          children: List.generate(local.length, (index) {
                            return Container(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProductList(local[index]),
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
                                          imageUrl: local[index].imageUrl,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                      ),
                                      ListTile(
                                          title: Text(
                                        local[index].name,
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
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 6.0, left: 8.0, right: 8.0, bottom: 10),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/banner-2.png'),
                          ),
                        ),
                      )
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
}
