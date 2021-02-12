import 'package:flutter/material.dart';
import 'package:zooland/src/models/pet_model.dart';
import 'package:zooland/src/pages/home/profile/forms/edit_pet_form.dart';

class EditPetPage extends StatefulWidget {
  EditPetPage({Key key}) : super(key: key);
  
  @override
  _EditPetPageState createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  @override
  Widget build(BuildContext context) {
    final PetModel pet = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar mascota'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Datos de ${pet.name}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      EditPetForm(pet: pet)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
