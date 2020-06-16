import 'package:flutter/material.dart';
import 'package:neon/screens/auth_screen.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

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
        routes: {
          '/home':(context)=>HomeScreen('email','username'),
        },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.redAccent[200],

      ),
      //home: HomeScreen(),
      //home: LoginScreen(),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder:(ctx,userSnapshot){
        if(userSnapshot.hasData){
          return HomeScreen('email','username');
        }
        return AuthScreen();
      }),

    );
  }
}
