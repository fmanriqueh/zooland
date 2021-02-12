import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:zooland/src/models/pet_model.dart';
import 'package:zooland/src/providers/match_provider.dart';
import 'package:zooland/src/providers/pets_provider.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({Key key, this.petModel, this.isEditable = false}) : super(key: key);

  final PetModel petModel;
  final bool isEditable;

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  var _tapPosition;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              widget.isEditable ? Padding(
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
                      _showPicker(context, PetsProvider.instance.updatePicture);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(CircleBorder()),
                    ),
                  ),
                ),
              ):Container(width: 0.0,height: 0.0),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage:  
                      widget.petModel == null ? AssetImage("assets/images/no-photo.jpg")
                      : widget.petModel.pictureUrl == null ? AssetImage("assets/images/no-photo.jpg")
                      : NetworkImage(
                        widget.petModel.pictureUrl
                      ),
                    backgroundColor:  Colors.transparent,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    widget.petModel == null ? "":"${widget.petModel.name}",
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height:10.0),
                  Text(
                    widget.petModel == null ? "":"${widget.petModel.breed ?? ''}",
                    style: TextStyle(color: Colors.grey, fontSize: 15.0)
                  ),
                  !widget.isEditable ? RoundedButton(
                    child: Text('Emparejar'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Seleccionar mascota"),
                            content: FutureBuilder(
                              future: PetsProvider.instance.fetchPets(Auth.instance.user.uid),
                              builder: (_, snapshot) {
                                if(snapshot.hasData) {
                                  return snapshot.data.length == 0 ?
                                     Text('No tiene mascotas registradas'):
                                     Container(width: double.maxFinite,child: _showPet(snapshot.data, context));
                                } else if(snapshot.hasError) {
                                  return Text('Algo salió mal...');
                                }
                                return Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 15
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      ).then((ownerPet) {
                        if(ownerPet != null){
                          MatchProvider.instance.createMatch(ownerPet, widget.petModel);
                        }
                      });
                    },
                  ): Container(width:0.0, height: 0.0)
                ],
              ),
              widget.isEditable ? Padding(
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
                      Navigator.of(context).pushNamed('/update-pet', arguments: widget.petModel);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(CircleBorder()),
                    ),
                  ),
                ),
              ):
              Container(width: 0.0,height: 0.0)
            ],
          ),
          SizedBox(height: 10.0),
          _showPictures(widget.petModel, context, widget.isEditable)
        ],
      ),
    );
  }

  _imgFromCamera(addPicture) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    addPicture(image: image, id: widget.petModel.uid);
  }

  _imgFromGallery(addPicture) async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50);
    addPicture(image: image, id: widget.petModel.uid); 
  }

  _showPicker(context, addPicture) {
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
                    _imgFromGallery(addPicture);
                      Navigator.of(context).pop();
                  }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camara'),
                  onTap: () {
                    _imgFromCamera(addPicture);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
  }

  Widget _showPictures(PetModel petModel, context, isEditable) {
    if(!isEditable && petModel.photos.length == 0) {
      return Container(height: 0.0, width: 0.0);
    }
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: petModel.photos.length,
            itemBuilder: (_, index) {
              return Row(
                children: [
                  _showPicture(petModel.photos[index], petModel, isEditable, context),
                  SizedBox(width:10.0),
                ],
              );
            }
          ),
          petModel.photos.length <5  && isEditable ? _addPetPicture(context):Container(height: 0.0,width: 0.0),
        ],
      ),
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  Widget _showPicture(url, PetModel petModel, isEditable, context) {
    return InkWell(
      onTapDown: isEditable ? _storePosition: null,
      onLongPress: isEditable ? () {
        final RenderBox overlay = Overlay.of(context).context.findRenderObject();
        showMenu(
          context: context,
          position:RelativeRect.fromSize(
            _tapPosition & const Size(40, 40),
            overlay.semanticBounds.size
          ),
          items: <PopupMenuEntry>[
            PopupMenuItem(
              value: true,
              child: Text('Eliminar'),
            )
          ]
        ).then((value) {
          if(value) {
            PetsProvider.instance.deletePicture(petModel.uid, url);
          }
        });
      }:null,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(petModel.pictureUrl),
                ),
                SizedBox(width: 20.0),
                Text('${petModel.name}')
              ],
            ),
            content: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover
                )
              )
            ),
            contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal:0.0),
            titlePadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0)
          )
        );
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
              url
            ),
            fit: BoxFit.cover
          )
        )
      ),
    );
  }

  Widget _addPetPicture(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPicker(context, PetsProvider.instance.addPicture);
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color.fromRGBO(150, 150, 150, 1)),
          color: Color.fromRGBO(0, 0, 0, 0.04)
        ),
        child: Center(
          child: Icon(
            Icons.add_a_photo
          )
        ),
      )
    );
  }

  Widget _showPet(List<PetModel> pets, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pets.length,
      itemBuilder: (_, index) {
        final pet = pets[index];
        return ListTile(
          title: Text(pet.name),
          subtitle: Text('${pet.type} | ${pet.breed}'),
          contentPadding: EdgeInsets.symmetric(horizontal:20.0, vertical: 7.0),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              pet.pictureUrl
            ),
          ),
          trailing: Icon(
            pet.sex == 'masculino' ?  MdiIcons.genderMale : MdiIcons.genderFemale,
            color: pet.sex == 'masculino' ? Colors.blue : Colors.pink,
          ),
          onTap: () {
            Navigator.pop(context, pet);
          },
        );
      } 
    );
  }
}