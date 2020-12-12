import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neon/authentication/auth.dart';
import 'package:neon/screens/menu_screen.dart';
import 'package:neon/widgets/FadeAnimation.dart';

class AuthForm extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  AuthForm({this.auth, this.onSignedIn});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        setState(() {
          _isLoading = true;
        });
        if (_isLogin) {
          String userId = await widget.auth.signInWithEmailAndPassword(
              _userEmail.trim(), _userPassword.trim());
          print('Ingresado: $userId');
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(
              _userEmail.trim(), _userPassword.trim());
          print('Usario registrado: $userId');
        }
        widget.onSignedIn();
      } on PlatformException catch (err) {
        var message =
            'Ha ocurrido un error, Por favor revise sus credenciales!';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
              ),
              FadeAnimation(
                  1.2,
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 1, 2, 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 10.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Por favor, introduce una dirección de correo válida.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Correo Electrónico',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            onSaved: (value) {
                              _userEmail = value;
                            },
                          ),
                        ),
                        if (!_isLogin)
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                          ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextFormField(
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'La contraseña debe tener al menos 7 caracteres de longitud.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                            onSaved: (value) {
                              _userPassword = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 25),
              if (_isLoading)
                CircularProgressIndicator(backgroundColor: Colors.redAccent),
              if (!_isLoading)
                FadeAnimation(
                    2,
                    Container(
                      height: 40,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        child: RaisedButton(
                          color: Colors.redAccent,
                          disabledColor: Colors.transparent,
                          textColor: Colors.white,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Text(
                              _isLogin ? 'Iniciar Sesión' : 'Regístrate',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            validateAndSubmit();
                          },
                        ),
                      ),
                    )),
              SizedBox(height: 25),
              if (!_isLoading)
                FadeAnimation(
                    2,
                    Container(
                      height: 40,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _signInButton(),
                    )),
              if (!_isLoading)
                FadeAnimation(
                  1.5,
                  Container(
                    child: InkWell(
                      child: FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          _isLogin
                              ? 'Crear una nueva cuenta'
                              : 'Ya tengo una cuenta',
                          style: TextStyle(
                              color: Color.fromRGBO(195, 11, 78, .4),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        widget.auth.signInWithGoogle().whenComplete(() {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return MenuScreen();
          //     },
          //   ),
          // );
          widget.onSignedIn();
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                'Inicia sesión con Google',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
