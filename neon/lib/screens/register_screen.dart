import 'package:flutter/material.dart';
import 'package:neon/screens/home_screen.dart';
import 'package:neon/screens/login_screen.dart';
import 'package:neon/widgets/FadeAnimation.dart';

class RegisterScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/backgroundR.png'),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.8,Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.redAccent,
                                    blurRadius: 10.0,
                                    offset: Offset(0,10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextFormField(
                                  validator: (value){
                                    if(value.isEmpty || !value.contains('@')){
                                      return 'Error ingrese un email valido.';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingresa Correo Electronico",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingrese Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        FadeAnimation(2,
                            Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(255, 0, 0, 1),
                                        Color.fromRGBO(255, 140, 39, 1),
                                      ]
                                  )
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen('','')),
                                  );
                                },
                                child: Center(
                                  child: Text("Registrarse",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 10,),
                        FadeAnimation(2,
                            Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(210, 26, 0, 1),
                                        Color.fromRGBO(255, 64, 64, 1),
                                      ]
                                  )
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Center(
                                  child: Text("Atras",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
      onWillPop: () {
        return new Future(() => false);
      },
    );
  }
}