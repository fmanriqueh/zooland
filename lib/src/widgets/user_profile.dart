import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zooland/src/providers/profile_provider.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/utils/image_picker_modal.dart';
import 'package:zooland/src/models/profile_model.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key, this.profileModel, this.isEditable = false}) : super(key: key);

  final ProfileModel profileModel;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundedButton(
              child: Row(
                children: [
                  Text('Salir'),
                  SizedBox(width: 10.0,),
                  Icon(Icons.logout)
                ],
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            isEditable ? Padding(
              padding: EdgeInsets.only(bottom:60),
              child: ButtonTheme(
                minWidth: 20.0,
                height: 40.0,
                child: ElevatedButton(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _showPicker(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                ),
              ),
            ): Container(width: 0.0, height: 0.0),
            Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 46.0,
                  backgroundImage:  
                    profileModel == null ? AssetImage("assets/images/no-photo.jpg")
                    : profileModel.pictureUrl == null ? AssetImage("assets/images/no-photo.jpg")
                    : NetworkImage(
                      profileModel.pictureUrl
                    ),
                  backgroundColor:  Colors.transparent,
                ),
                SizedBox(height: 20.0),
                Text(
                  profileModel == null ? "":"${profileModel.name}",
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                SizedBox(height:10.0),
                Text(
                  profileModel == null ? "":"${profileModel.location ?? ''}",
                  style: TextStyle(color: Colors.grey, fontSize: 15.0)
                )
              ],
            ),
            isEditable ? Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: ButtonTheme(
                minWidth: 20.0,
                height: 40.0,
                child: ElevatedButton(
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // edit profile
                    Navigator.of(context).pushNamed('/update-profile');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                ),
              ),
            ): Container(width: 0.0,height: 0.0)
          ],
        ),
      ]
    );
  }
  
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    ProfileProvider.instance.addPicture(image);
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50);
    ProfileProvider.instance.addPicture(image);
  }

  File _showPicker(context) {
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