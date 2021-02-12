import 'package:flutter/material.dart';

import 'package:zooland/src/providers/profile_provider.dart';
import 'package:zooland/src/utils/progress_dialog.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key key}) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  ProfileProvider _profileProvider = ProfileProvider.instance;

  final _formKey = GlobalKey<FormState>();
  final _name = GlobalKey<CustomTextFormFieldState>();
  final _location = GlobalKey<CustomTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              key: _name,
              hint: "Nombre del usuario",
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _location,
              hint: "Dirección",
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 15.0),
            RoundedButton(
              child: Text("Actualizar"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ProgressDialog().showProgressNormal(
                    context: context,
                    future: _profileProvider.updateProfile(
                        name: _name.currentState.value,
                        location: _location.currentState.value
                    ));
                }
              })
          ],
        ));
  }
}
