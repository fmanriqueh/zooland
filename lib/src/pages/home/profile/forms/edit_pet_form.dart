import 'package:flutter/material.dart';

import 'package:zooland/src/models/pet_model.dart';
import 'package:zooland/src/providers/pets_provider.dart';
import 'package:zooland/src/utils/progress_dialog.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class EditPetForm extends StatefulWidget {
  const EditPetForm({Key key, this.pet}) : super(key: key);

  final PetModel pet;

  @override
  _EditPetFormState createState() => _EditPetFormState();
}

class _EditPetFormState extends State<EditPetForm> {
  PetsProvider _petsProvider = PetsProvider.instance;

  final _formKey = GlobalKey<FormState>();
  final _name  = GlobalKey<CustomTextFormFieldState>();
  final _type  = GlobalKey<CustomTextFormFieldState>();
  final _breed = GlobalKey<CustomTextFormFieldState>();
  final _sex   = GlobalKey<CustomTextFormFieldState>();
  final _age   = GlobalKey<CustomTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            key: _name,
            hint: "Nombre de la mascota",
            text: widget.pet.name,
            validator: null
          ),
          SizedBox(height: 15.0),
          CustomTextFormField(
            key: _type,
            hint: "Tipo",
            text: widget.pet.type,
            validator: null
          ),
          SizedBox(height: 15.0),
          CustomTextFormField(
            key: _breed,
            hint: "Raza",
            text: widget.pet.breed,
            validator: null
          ),
          SizedBox(height: 15.0),
          CustomTextFormField(
            key: _sex,
            hint: "Sexo",
            text: widget.pet.sex,
            validator: null
          ),
          SizedBox(height: 15.0),
          CustomTextFormField(
            key: _age,
            hint: "Edad en años",
            text: widget.pet.age,
            validator: null
          ),
          SizedBox(height: 15.0),
          RoundedButton(
              child: Text("Guardar"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ProgressDialog().showProgressNormal(
                    context: context,
                    future: _petsProvider.updatePet(
                        name: _name.currentState.value,
                        type: _type.currentState.value,
                        breed: _breed.currentState.value,
                        sex: _sex.currentState.value,
                        age: _age.currentState.value,
                        id: widget.pet.uid
                    )
                  );
                }
              }   
            )
          ],
        ));
  }
}
