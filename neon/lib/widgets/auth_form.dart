import 'package:flutter/material.dart';
import 'package:neon/screens/auth_screen.dart';
import 'package:neon/screens/menu_screen.dart';
import 'package:neon/widgets/FadeAnimation.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
      this.submitFn,
      this.isLoading,
      );

  final bool isLoading;
  final void Function(
      String email,
      String password,
      String userName,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
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
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  FadeAnimation(1.2,Container(
                    padding: EdgeInsets.fromLTRB(5, 1, 2, 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                                hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            onSaved: (value) {
                              _userEmail = value;
                            },
                          ),
                        ),
                        if (!_isLogin)
                          Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
                          ),
                          child: TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Por favor ingrese al menos 4 caracteres.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nombre de Usuario',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                            ),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
                          ),
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
                  if (widget.isLoading) CircularProgressIndicator(backgroundColor: Colors.redAccent),
                  if (!widget.isLoading)
                    FadeAnimation(2,
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
                              child: Text(_isLogin ? 'Iniciar Sesión' : 'Regístrate',
                              style:TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: _trySubmit,
                            ),
                          ),
                        )),
                  SizedBox(height: 25),
                  if (!widget.isLoading)
                    FadeAnimation(2,
                        Container(
                          height: 40,
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: _signInButton(),
                        )),
                  if (!widget.isLoading)
                    FadeAnimation(1.5,
                      Container(
                        child: InkWell(
                          child: FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              _isLogin
                                ? 'Crear una nueva cuenta'
                                : 'Ya tengo una cuenta',
                              style: TextStyle(color: Color.fromRGBO(195, 11, 78, .4),
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
         signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return MenuScreen();
          },
        ),
      );
    });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Iniciar Sesión con Google',
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
