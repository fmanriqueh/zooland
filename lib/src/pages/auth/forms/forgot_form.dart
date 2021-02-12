import 'package:flutter/material.dart';

import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';
import 'package:zooland/src/utils/progress_dialog.dart';
import 'package:zooland/src/utils/validators.dart';

class ForgotForm extends StatefulWidget {
  @override
  _ForgotFormState createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {

  final Auth _auth = Auth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<CustomTextFormFieldState>();

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
          RoundedButton(
            onPressed: () async {
              if(_formKey.currentState.validate()){
                ProgressDialog().showProgress(
                  context: context,
                  future: _auth.resetPassword(context, email: _emailKey.currentState.value)
                );
              }
            },
            child: Text('Enviar')
          ),
        ]
      ),
    );
  }
}