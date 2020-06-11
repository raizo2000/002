import 'package:flutter/material.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:neon/screens/login_screen.dart';


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
        title: 'Flutter Food Delivery UI',
        initialRoute: '/',
        routes: {
          '/home':(context)=>HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[50],
          primaryColor: Colors.redAccent[200],

        ),
        //home: HomeScreen(),
        home: LoginScreen(),


    );
  }
}
