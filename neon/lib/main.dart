import 'package:flutter/material.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/root/root.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:neon/screens/menu_screen.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light
  ));
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahh!! Vender!!!',
       initialRoute: '/',
        // routes: {
        //   '/home':(context)=>HomeScreen('email','username'),
        //   '/menu':(context)=>MenuScreen(),
        // },
          routes: {
          '/home':(context)=>RootPage(auth: new Auth()),
        },
        
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.redAccent[200],

      ),
      //home: HomeScreen(),
      //home: LoginScreen(),
      home: new RootPage(auth: new Auth()),

    );
  }
}
