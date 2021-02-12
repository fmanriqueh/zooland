import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:zooland/src/providers/pets_provider.dart';
import 'package:zooland/src/utils/progress_dialog.dart';
import 'package:zooland/src/widgets/custom_dropdown_button.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class AddPetForm extends StatefulWidget {
  const AddPetForm({Key key}) : super(key: key);

  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  PetsProvider _petsProvider = PetsProvider.instance;

  final _formKey = GlobalKey<FormState>();
  final _name  = GlobalKey<CustomTextFormFieldState>();
  final _type  = GlobalKey<CustomTextFormFieldState>();
  final _breed = GlobalKey<CustomTextFormFieldState>();
  final _sex   = GlobalKey<CustomDropdownButtonState>();
  final _age   = GlobalKey<CustomTextFormFieldState>();
  File _image;

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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar un nombre';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _type,
              hint: "Tipo",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar una tipo';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _breed,
              hint: "Raza",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar una raza';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomDropdownButton(
              key: _sex,
              hint: 'Sexo'
            ),
            /*SizedBox(height: 15.0),
            CustomTextFormField(
              key: _sex,
              hint: "Sexo",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar un sexo';
                }
                return null;
              },
            ),*/
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _age,
              hint: "Edad en años",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar una edad';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.black,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(220, 220, 220, 1),
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          )),
              ),
            ),
            RoundedButton(
                child: Text("Agregar mascota"),
                onPressed: () {
                  print(_sex.currentState);
                  if (_image == null) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Debe agregar una imagen.")));
                  }
                  if (_formKey.currentState.validate() && _image != null) {
                    ProgressDialog().showProgressNormal(
                      context: context,
                      future: _petsProvider.addPet(
                        name: _name.currentState.value,
                        type: _type.currentState.value,
                        breed: _breed.currentState.value,
                        sex: _sex.currentState.value,
                        age: _age.currentState.value,
                        image: _image
                      )
                    );
                  }
                })
          ],
        ));
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Galería'),
                  onTap: () {
                    _imgFromGallery();
                      Navigator.of(context).pop();
                  }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camara'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
  }
}
