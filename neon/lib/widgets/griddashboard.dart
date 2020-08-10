import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:neon/screens/tecno_screen.dart';

class GridDashboard extends StatefulWidget {
 final  BaseAuth auth;
  final  VoidCallback onSignedOut;
  GridDashboard({this.auth, this.onSignedOut});

  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  
  

   Items item1,item2,item3;

  @override
  void initState() {
    super.initState();
     item1 = new Items(
      title: "Tecnologia",
      subtitle: "Lo ultimo en dispositivos.",
      event: "",
      img: "assets/items/computadora.png",
      page: TecnoScreen("Tecnologia",widget.auth,widget.onSignedOut),

  );
    item2 = new Items(
      title: "Comida",
      subtitle: "Deseas un Antojito!!",
      event: "",
      img: "assets/items/comida-rapida.png",
      page: HomeScreen(widget.auth,widget.onSignedOut),
  );
    item3 = new Items(
      title: "SuperMercado",
       subtitle:  "Todo lo que tu necesitas!!",
      event: "",
      img: "assets/items/carrito-de-compras.png",
      page: TecnoScreen("SuperMercado",widget.auth,widget.onSignedOut),
  );
  }
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
     //List<Items> myList = [item1, item2, item3, item4];
    //var color = 0xffeeeeee;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 3
                  ),
              ),
              child: InkWell(
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.event,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => data.page));
                  },
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  var page;
  Items({this.title, this.subtitle, this.event, this.img, this.page});
}