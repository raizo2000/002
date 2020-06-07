import 'dart:math';
import 'package:neon/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:neon/models/food.dart';
import 'package:neon/models/restaurant.dart';
import 'package:neon/screens/login_screen.dart';
import 'package:neon/screens/restaurant_screen.dart';
import 'package:neon/widgets/rating_starts.dart';

import 'cart_screen.dart';
import 'about_screen.dart';
import 'order_screen.dart';
import 'package:neon/widgets/categories_items.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<Restaurant> restauranteList = [];

  List<String> idList= [];

//esto es el dise;o de cada uno de los restaurantes


  @override
  void initState(){

    super.initState();

    DatabaseReference restRef =
    FirebaseDatabase.instance.reference().child("restaurant");
    restRef.once().then((DataSnapshot snap) {

      var keysr = snap.value.keys;
      var data = snap.value;

      restauranteList.clear();
       for (var individualKey in keysr) {
         idList.add(individualKey);
      /*  DatabaseReference menuRef =  FirebaseDatabase.instance.reference().child("restaurant/$individualKey/menu");
         print("Estoy primer for");
             menuRef.once().then((DataSnapshot menuSnap) {

               var menuKeys = menuSnap.value.keys;
               var menuData = menuSnap.value;
               menuList.clear();
                for(var keymenu in menuKeys){
                   print("Estoy en el segundo for");
                 Food food = Food(
                   menuData[keymenu]['imageUrl'],
                     menuData[keymenu]['name'],
                     menuData[keymenu]['price']
                      );
                  print("Menu:$food");
                 menuList.add(food);
                 print(menuList.length);
               }
             });*/
        Restaurant rest = Restaurant(
            data[individualKey]['address'],
            data[individualKey]['city'],
            data[individualKey]['imageUrl'],
            isListFood(individualKey),
            data[individualKey]['name'],
            data[individualKey]['rating'],
            data[individualKey]['typeStore'],
            individualKey

        );

        print("idList=$idList.length");
       // print('name: $data[individualKey]["name"]');
        restauranteList.add(rest);

      }
      setState(() {
      });
    });

  }
  List<Food> isListFood(String id) {
    List<Food> menuList = [];
    menuList.clear();
    DatabaseReference menuRef =  FirebaseDatabase.instance.reference().child("restaurant/$id/menu");

    menuRef.once().then((DataSnapshot menuSnap) {

      var menuKeys = menuSnap.value.keys;
      var menuData = menuSnap.value;
      menuList.clear();
      for(var keymenu in menuKeys){
        print("Estoy en el segundo for");
        Food food = Food(
            menuData[keymenu]['imageUrl'],
            menuData[keymenu]['name'],
            (menuData[keymenu]['price']).toDouble()
        );
        print("Menu:$food");
        menuList.add(food);
        print(menuList.length);
      }
    });
    return menuList;
  }

  _buildNearlyRestaurant() {

    List<Widget> restaurantList = [];

    restauranteList.forEach((Restaurant restaurant) {
      restaurantList.add(

          GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantScreen(restaurant: restaurant),
                ),
                //selecciona a cada uno de los restaurantes del slider en esp;ol es el llamado
              ),
              child:
              Container(

                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1.0,
                        color: Colors.redAccent[200]
                    )
                ),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Hero(
                            tag: restaurant.name,
                            child: Image.network(
                             restaurant.imageUrl,
                              fit:BoxFit.cover,
                              height: 150.0,
                              width: 150.0,
                            ),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0,),
                          RatingStarts(rating: restaurant.rating, taille: 26.0,),
                          Text(
                            restaurant.address,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0,),
                          Text(
                            'Latacunga',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
      );
    });

    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          //barra superior
          title: Text(""),
          iconTheme: new IconThemeData(
            color: Colors.white,
            size: 36.0,
          ),
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
                        child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 30.0
                        ),
                        onPressed: () => Navigator.push(
                         
                            context,
                            MaterialPageRoute(
                                builder: (_) => CartScreen()
                            )
                        )
                    )
                ),
               /* Positioned(
                  bottom: 37.0,
                  right: 30.0,
                  child: Text(
                      '${currentUser.cart.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:  Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        //  letterSpacing: 1.2
                      )
                  ),
                )*/
              ],
            ),
          ],
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('User'),
                accountEmail: new Text('user@gmail.com'),
                currentAccountPicture: new Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              new ListTile(
                title: new Text('PERFIL'),
                leading: IconButton(
                  icon: Icon(Icons.home,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context,new MaterialPageRoute(
                      builder: (BuildContext context)=> new AboutScreen())
                  );
                },
              ),
              new Divider(
                color: Colors.redAccent,
                height: 5.0,
              ),

              new ListTile(
                title: new Text('ORDEN'),
                leading: IconButton(
                  icon: Icon(
                    Icons.import_contacts,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context,new MaterialPageRoute(
                      builder: (BuildContext context)=> new OrderScreen())
                  );
                },
              ),
              new Divider(
                color: Colors.redAccent,
                height: 5.0,
              ),

                new ListTile(
                  title: new Text('SALIR'),
                  leading: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(context,new MaterialPageRoute(
                        builder: (BuildContext context)=> new LoginScreen())
                    );
                  },
                ),
                new Divider(
                  color: Colors.redAccent,
                  height: 5.0,
                ),


            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(18.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor)
                      ),
                      hintText: 'Busca tu Restaurante Favorito!!',
                      prefixIcon: Icon(
                          Icons.search,
                          size: 30.0
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {},
                      )
                  ),
                )
            ),
            //RecentOrders()
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                      'Categorias:',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.4,
                      )
                  ),
                ),
              ],
            ),
            CategoriesItems(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                      'Establecimientos:',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.4,
                      )
                  ),
                ),
                //Aqui llama a la lista de restaurenates en esta funcion
                _buildNearlyRestaurant()
              ],
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: (){
            _settingModalBottomSheet(context);
          },
          child: new Icon(
            Icons.location_city,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void _settingModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(
                    Icons.opacity,
                    color: Colors.redAccent,
                  ),
                  title: new Text('Ambato'),
                  onTap: () => {
                    Navigator.pop(context)
                  }
              ),
              new ListTile(
                  leading: new Icon(
                    Icons.opacity,
                    color: Colors.redAccent,
                  ),
                  title: new Text('La Mana'),
                  onTap: () => {
                    Navigator.pop(context)
                  }
              ),
              new ListTile(
                leading: new Icon(
                    Icons.opacity,
                    color: Colors.redAccent,
                ),
                title: new Text('Mejia'),
                onTap: () => {
                  Navigator.pop(context)
                },
              ),
            ],
          ),
        );
      }
  );
}