import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:zooland/src/pages/auth/forms/register_form.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, @required this.onGoToLogin}) : super(key: key);

  final VoidCallback onGoToLogin;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 18.0,
            left: 18.0,
            right: 18.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Crear cuenta",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10.0,),
              RegisterForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿Ya tiene cuenta?"),
                  CupertinoButton(
                    onPressed: widget.onGoToLogin,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      "Inicia sesión.",
                      style: TextStyle(
                        color: Theme.of(context).accentColor
                      ),
                    ),
                  )
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}