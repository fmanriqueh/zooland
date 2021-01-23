import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';
import 'package:zooland/src/utils/validators.dart';
import 'package:zooland/src/utils/progress_dialog.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey     = GlobalKey<FormState>();
  final _emailKey    = GlobalKey<CustomTextFormFieldState>();
  final _passwordKey = GlobalKey<CustomTextFormFieldState>();



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextFormField(
            key: _emailKey,
            hint: "Correo electrónico",
            validator: (value) => Validators.emailValidator(value)
          ),
          SizedBox(height: 15.0),
          CustomTextFormField(
            key: _passwordKey,
            hint: "Contraseña",
            isPassword: true,
            validator: (value){
              if(value.isEmpty){
                return 'Debe ingresar una contraseña';
              }
              return null;
            },
          ),
          RoundedButton(
            onPressed: () {
              if(_formKey.currentState.validate()){
                ProgressDialog().showProgressLogin(
                  context: context,
                  future: Auth.instance.loginWithEmailAndPassword(
                    context,
                    email: _emailKey.currentState.value,
                    password: _passwordKey.currentState.value
                  )
                );
              }
            },
            child: Text("Ingresar")
          ),
        ]
      ),
    );
  }
}