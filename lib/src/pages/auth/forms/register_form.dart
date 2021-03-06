import 'package:flutter/material.dart';

import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/utils/validators.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final Auth _auth = Auth.instance;

  final _formKey     = GlobalKey<FormState>();
  final _nameKey     = GlobalKey<CustomTextFormFieldState>();
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
            key: _nameKey,
            hint: "Nombre",
            validator: (value) => value.isEmpty ? 'Debe ingresar un nombre':null
          ),
          SizedBox(height: 10.0),
          CustomTextFormField(
            key: _emailKey,
            hint: "Correo electrónico",
            validator: (value) => Validators.emailValidator(value)
          ),
          SizedBox(height: 5.0),
          CustomTextFormField(
            key: _passwordKey,
            hint: "Contraseña",
            isPassword: true,
            validator: (value) => Validators.passwordValidator(value)
          ),
          SizedBox(height: 10.0),
          CustomTextFormField(
            hint: "Confirmar contraseña",
            isPassword: true,
            validator: (value){
              if(value.isEmpty){
                return 'Debe ingresar su contraseña';
              }else if(value != _passwordKey.currentState.value){
                return 'Las constrañas deben coincidir';
              }
              return null;
            },
          ),
          RoundedButton(
            onPressed: () async {
              if(_formKey.currentState.validate()){
                _auth.signupWithEmailAndPassword(
                  context,
                  name: _nameKey.currentState.value, 
                  email: _emailKey.currentState.value,
                  password: _passwordKey.currentState.value
                );
              }
            },
            child: Text("Registrarse")
          ),
        ]
      ),
    );
  }
}