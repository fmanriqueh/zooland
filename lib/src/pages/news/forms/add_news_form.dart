import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:zooland/src/widgets/date_form_field.dart';

import '../../../providers/news_provider.dart';
import '../../../providers/news_provider.dart';
import '../../../utils/progress_dialog.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/rounded_button.dart';

class AddNewsForm extends StatefulWidget {
  const AddNewsForm({Key key}) : super(key: key);

  @override
  _AddNewsFormState createState() => _AddNewsFormState();
}

class _AddNewsFormState extends State<AddNewsForm> {
  NewsProvider _newsProvider = NewsProvider.instance;

  final _formKey = GlobalKey<FormState>();
  final _headlineKey = GlobalKey<CustomTextFormFieldState>();
  final _summaryKey = GlobalKey<CustomTextFormFieldState>();
  final _placeKey = GlobalKey<CustomTextFormFieldState>();
  final _dateKey = GlobalKey<DateFormFieldState>();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              key: _headlineKey,
              hint: "Título del evento",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar un título';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _summaryKey,
              hint: "Descripción",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar una descripción';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _placeKey,
              hint: "Lugar",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debe ingresar un lugar';
                }
                return null;
              },
            ),
            SizedBox(height: 15.0),
            DateFormField(
              key: _dateKey,
              hint: "Fecha del evento",
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
                child: Text("Agregar evento"),
                onPressed: () {
                  if (_image == null) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Debe agregar una imagen.")));
                  }
                  if (_formKey.currentState.validate() && _image != null) {
                    ProgressDialog().showProgressAndGoBack(
                        context: context,
                        future: _newsProvider.addNews(
                            headline: _headlineKey.currentState.value,
                            summary: _summaryKey.currentState.value,
                            date: _dateKey.currentState.value,
                            place: _placeKey.currentState.value,
                            image: _image));
                    /*ProgressDialog().showProgressLogin(
                context: context,
                future: Auth.instance.loginWithEmailAndPassword(
                  context,
                  email: _emailKey.currentState.value,
                  password: _passwordKey.currentState.value
                )
              );*/
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
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
