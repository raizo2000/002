import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:neon/screens/tecno_screen.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Tecnologia",
      subtitle: "Lo ultimo en dispositivos.",
      event: "3 Events",
      img: "assets/items/computadora.png",
      page: TecnoScreen("Tecnologia"),

  );

  Items item2 = new Items(
      title: "Comida",
      subtitle: "",
      event: "4 Items",
      img: "assets/items/comida-rapida.png",
      page: HomeScreen("",""),
  );
  Items item3 = new Items(
      title: "Compras",
      subtitle: "Lucy Mao going to Office",
      event: "",
      img: "assets/items/carrito-de-compras.png",
      page: HomeScreen("",""),
  );
  Items item4 = new Items(
      title: "Encomiendas",
      subtitle: "Rose favirited your Post",
      event: "",
      img: "assets/items/camion-de-comida.png",
      page: HomeScreen("",""),
  );



  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
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