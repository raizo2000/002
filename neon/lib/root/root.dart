
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/screens/auth_screen.dart';
import 'package:neon/screens/menu_screen.dart';
import 'package:neon/widgets/auth_form.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
    State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}


class _RootPageState extends State<RootPage>{
  
  AuthStatus authStatus = AuthStatus.notSignedIn;


  //metodo que llama cada vez un Statfulwidget es creada
  
  
  initState() { 
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }


  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new AuthScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
          );
      case AuthStatus.signedIn:
     
        return new MenuScreen(
          auth: widget.auth,
          onSignedOut: _signedOut
        );
    }
    return new AuthScreen(auth: widget.auth);
  }
 
}