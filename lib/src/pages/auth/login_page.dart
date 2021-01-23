import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:zooland/src/pages/auth/forms/login_form.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/circle_button.dart';
//import 'package:zooland/src/widgets/progress_dialog.dart';
import 'package:zooland/src/utils/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.onGoToForgot, @required this.onGoToSignup}) : super(key: key);

  final VoidCallback onGoToForgot;
  final VoidCallback onGoToSignup;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                "Iniciar sesión",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height:10.0),
              LoginForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: widget.onGoToForgot,
                    padding: EdgeInsets.symmetric(horizontal: 3,vertical: 0),
                    child: Text(
                      "¿Ha olvidado su contraseña?",
                      style: TextStyle(
                        color: Theme.of(context).accentColor
                      ),
                    ),
                  ),
                ],
              ),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Divider(
                        color: Colors.black26,
                        height: 36,
                      )),
                ),
                Text(
                  "O",
                  style: TextStyle(
                    fontWeight: FontWeight.w400
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Divider(
                        color: Colors.black26,
                        height: 36,
                      )),
                ),
              ]),
              Text("Ingresa con:"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    onPressed: (){
                      //Auth.instance.loginWithFacebook(context);
                    },
                    iconPath: "assets/icons/pages/login/facebook.svg"
                  ),
                  CircleButton(
                    onPressed: () {

                      ProgressDialog().showProgressLogin(
                        future: Auth.instance.loginWithGoogle(context),
                        context: context
                      );
                      
                      /*ProgressDialog().test(context,
                        Future.delayed(Duration(seconds: 5),() => "12")                        
                      );
                      
                      ProgressDialog().show(context);
                      final User user = await Auth.instance.loginWithGoogle(context);
                      ProgressDialog().dismiss(context);
                      
                      if(user != null){
                        Navigator.popAndPushNamed(context, '/');
                      }*/
                      //Scaffold.of(context).showSnackBar(SnackBar(content:Text("Algo salió mal")));
                    },
                    iconPath: "assets/icons/pages/login/google.svg"
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿Eres nuevo?"),
                  CupertinoButton(
                    onPressed: widget.onGoToSignup,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      "Regístrate",
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