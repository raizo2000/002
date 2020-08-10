import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/main.dart';
import 'package:neon/root/root.dart';
import 'package:neon/screens/auth_screen.dart';
import 'package:neon/screens/menu_screen.dart';
import 'package:neon/screens/order_screen.dart';

class AppDrawer extends StatefulWidget {
   final BaseAuth auth;
  final VoidCallback onSignedOut;
  AppDrawer(this.auth,this.onSignedOut);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
 
  // void _signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.onSignedOut();
  //     print("Estoy en el drawer lin22 dentro del try");
  //   } catch (e) {
  //     print("catch draver lna24"+e);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
          return  ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                ),
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
                  onPressed: (){},
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
                title: new Text('CATEGORIAS'),
                leading: IconButton(
                  onPressed: (){

                  },
                  icon: Icon(
                    Icons.category,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             new MenuScreen(auth: widget.auth,onSignedOut: widget.onSignedOut)));
                  },
              ),
              new Divider(
                color: Colors.redAccent,
                height: 5.0,
              ),
              new ListTile(
                title: new Text('CERRAR SESIÓN'),
                leading: IconButton(
                onPressed: (){},
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.redAccent,
                  ),
                ),
              onTap: () {
               widget.onSignedOut();
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //         new AuthScreen(auth: new Auth())));
                  //        Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) {
                  //   return RootPage(auth: new Auth());
                  // }), ModalRoute.withName('/'));
                 
                
                },
              ),
              new Divider(
                color: Colors.redAccent,
                height: 5.0,
              ),
            ],
          );
  }
}
