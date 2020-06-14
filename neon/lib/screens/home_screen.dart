
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:neon/models/food.dart';
import 'package:neon/models/restaurant.dart';
import 'package:neon/screens/restaurant_screen.dart';
import 'package:neon/widgets/rating_starts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cart_screen.dart';

import 'order_screen.dart';


class HomeScreen extends StatefulWidget {

  HomeScreen(
    this.email,
    this.username,
    {this.key}
      );

  final Key key;
  final String email;
  final String username;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  final myTextController = TextEditingController();
  String searchCategory;

  List<Restaurant> restauranteList = [];
  List<Restaurant> auxRestauranteList = [];
  List<Restaurant> filteredRestauranteList = [];
  DatabaseReference restRef = FirebaseDatabase.instance.reference().child("restaurant");
 // List<Restaurant> restaurantForDisplay= [];
  List<String> idList= [];
  List<String> cityList = [];

//esto es el dise;o de cada uno de los restaurantes

  @override
  void initState(){
    _fillCity();
    super.initState();



    restRef.orderByChild("city").equalTo("Latacunga").once().then((DataSnapshot snap) {

      var keysr = snap.value.keys;
      var data = snap.value;
      auxRestauranteList.clear();
      restauranteList.clear();
      idList.clear();
       for (var individualKey in keysr) {
         idList.add(individualKey);

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
        auxRestauranteList = restauranteList;
       // restauranteList = filteredRestauranteList;
      });
    });

  }
  @override
  void dispose(){
    myTextController.dispose();
    super.dispose();
  }


  _fillCity(){
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
                            restaurant.city,
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
                accountName: new Text('BIenvenido',textAlign: TextAlign.center,),
                accountEmail: new Text('!!Lo Necesitas, te lo Llevamos!!'),
                currentAccountPicture: Image(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              /*new ListTile(
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
              ),*/
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
                  title: new Text('CERRAR SESIÓN'),
                  leading: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: (){
                    FirebaseAuth.instance.signOut();
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
                  controller: myTextController,
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
                             ),

                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                            myTextController.clear();
                            FocusScope.of(context).requestFocus(new FocusNode());
                            setState(() {
                              restauranteList = auxRestauranteList;
                            });

                        },
                      )
                  ),
                  onChanged: (text){
                    text = text.toLowerCase();
                    setState(() {
                      restauranteList = auxRestauranteList.where((restau){
                        var restName = restau.name.toLowerCase();
                        return restName.contains(text);
                      }).toList();
                    });
                  }
                ),

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
               _fillCategory(),
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
            setState(() {
              _settingModalBottomSheet(context);
            });

          },
          child: new Icon(
            Icons.location_city,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context){

    _fillCity();
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc){

            return ListView.builder(
              shrinkWrap: true,
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child:   Wrap(
                    children: <Widget>[

                      new ListTile(
                          leading:  new Icon(
                            Icons.opacity,
                            color: Colors.redAccent,
                          ),
                          title:  new Text(
                             cityList[index]

                          ),
                          onTap: () => {
                            print(cityList[index]),
                            _searchCity(cityList[index]),
                          //  restauranteList = filteredRestauranteList,
                            Navigator.pop(context)
                          }
                      ),
                    ],
                  ),

                );
              }

            );

          }

      );

  }
  _searchCity(String city){
    restRef.orderByChild("city").equalTo(city).once().then((DataSnapshot snap) {

      if(snap.value!=null){
        var keysr = snap.value.keys;
        var data = snap.value;

        filteredRestauranteList.clear();
        for (var individualKey in keysr) {
          idList.add(individualKey);

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
          filteredRestauranteList.add(rest);

        }
        _cambiarState();
      }else{
        print("No exite restauranes");
        filteredRestauranteList.clear();
        _cambiarState();
      }


    });
  }
  _searchCategory(String category){

if(category != "Todo"){
  category =category.toLowerCase();
  // print("soy"+category);
  restauranteList = auxRestauranteList.where((restau){
    var restName = restau.typeStore.toLowerCase();
    print(restName);
    return restName.contains(category);
  }).toList();
  // print(restauranteList.length);


}else{
  setState(() {
    restauranteList = auxRestauranteList;
  });
}


setState(() {

});

  }

  _cambiarState(){
    setState(() {
      restauranteList = filteredRestauranteList;
      auxRestauranteList = filteredRestauranteList;

    });
  }
  _fillCategory(){
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _category(
            'assets/items/desechable.png',
            'Todo',
          ),
          _category(
             'assets/items/rapida.png',
             'Rapida',
          ),
          _category(
             'assets/items/pizza.png',
             'Pizzeria',
          ),
          _category(
             'assets/items/pan.png',
             'Panaderia',
          ),
          _category(
             'assets/items/panaderia.png',
             'Pasteleria',
          ),
          _category(
             'assets/items/dulces.png',
             'Dulceria',
          ),
          _category(
             'assets/items/biela.png',
             'Bebidas',
          ),
          _category(
             'assets/items/cocinar.png',
             'Agachaditos',
          ),
          _category(
             'assets/items/jugos.png',
             'Jugos',
          ),
          _category(
             'assets/items/cafe.png',
             'Cafeteria',
          ),

        ],
      ),
    );
  }
  _category(String image_location, String image_caption){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          searchCategory=image_caption;
          _searchCategory(searchCategory);
        },
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 80.0,
                height: 60.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption, style: new TextStyle(fontSize: 12.0),),
              )
          ),
        ),
      ),
    );
  }


}

