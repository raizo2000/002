
import 'package:flutter/material.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/widgets/griddashboard.dart';

import 'order_screen.dart';

class MenuScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  MenuScreen({this.auth,this.onSignedOut});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
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
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  'BIenvenido',
                  textAlign: TextAlign.center,
                ),
                accountEmail: new Text('!!Lo Necesitas, te lo Llevamos!!'),
                currentAccountPicture: Image(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
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
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new OrderScreen()));
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
                onTap: () {
                  // FirebaseAuth.instance.signOut();
                  // signOutGoogle();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) {
                  //   return AuthScreen();
                  // }), ModalRoute.withName('/'));
                  _signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/menu', (Route<dynamic> route) => false);
                },
              ),
              new Divider(
                color: Colors.redAccent,
                height: 5.0,
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            //SizedBox(
            // height: 110,
            //),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Image(
              image: AssetImage("assets/items/logogrande.png"),
              height: 300,
              width: 300,
            ),
            //SizedBox(
            //  height: 40,
            //),
            GridDashboard(auth: widget.auth,onSignedOut: _signOut,)
          ],
        ),
      ),
    );
  }
}
