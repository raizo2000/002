import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
   final BaseAuth auth;
  final VoidCallback onSignedIn;
  AuthScreen({this.auth,this.onSignedIn});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          AuthForm(
          auth: widget.auth,
          onSignedIn: widget.onSignedIn,
        ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
