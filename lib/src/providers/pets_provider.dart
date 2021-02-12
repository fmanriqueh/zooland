import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path/path.dart' as Path;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zooland/src/models/pet_model.dart';


class PetsProvider {
  PetsProvider._internal();
  static final PetsProvider instance = PetsProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<PetModel>> fetchPets(uid) async {
    final petRef = _database.reference()
      .child("pets")
      .orderByChild('ownerId')
      .equalTo(uid);

    return await petRef.once().then((snapshot) {
      if(snapshot.value == null) {
        return List();
      } else {
        return PetsList().fromJSON(snapshot.value);
      }
    });
  }

  Future<PetModel> fetchPet(uid) async {
    final petRef = _database.reference()
      .child("pets")
      .child(uid);
    return await petRef.once().then((snapshot) {
        return PetModel().fromJson(snapshot.key, snapshot.value);
    });
  }

  Future<void> addPet(
    {@required String name,
    @required String type,
    @required String breed,
    @required String sex,
    @required String age,
    @required File image}) async {
    String pictureUrl = await _uploadImage(image);
    PetModel _petModel = PetModel(
        name: name,
        type: type,
        ownerId: _auth.currentUser.uid,
        breed: breed,
        sex: sex,
        age: age,
        pictureUrl: pictureUrl);
    
    final newsRef = _database.reference().child("pets").push();
    return newsRef.set(_petModel.toJson());
  }

  Future<void> updatePet(
    {@required String name,
    @required String breed,
    @required String sex,
    @required String type,
    @required String age,
    @required String id,}) async {
    
    final newsRef = _database.reference().child("pets").child(id);
    return newsRef.update({
      name  == '' ? '': 'name' : name,
      breed == '' ? '': 'breed': breed,
      sex   == '' ? '': 'sex'  : sex,
      type  == '' ? '': 'type' : type,
      age   == '' ? '': 'age'  : age,
    });
  }

  Stream<Event> subscribePet(id){
    final petRef = _database.reference()
      .child("pets")
      .child(id);
    return petRef.onChildChanged;
  }

  Future<void> updatePicture({File image, id}) async {
    String pictureUrl = await _uploadImage(image);
    final pictureRef = _database.reference()
      .child("pets")
      .child(id)
      .child("pictureUrl");

    pictureRef.once().then((snapshot) async {
      if(snapshot.value != null) {
        Reference reference = _storage.refFromURL(snapshot.value);
        await reference.delete();
      }
      pictureRef.set(pictureUrl);
    });
  }

  Future<void> addPicture({File image, id}) async {
    String photoUrl = await _uploadImage(image);
    final photosRef = _database.reference()
      .child("pets")
      .child(id)
      .child("photos");

    photosRef.once().then((snapshot) async {
      if(snapshot.value != null) {
        return photosRef.child('photo${snapshot.value.length + 1}').set(photoUrl);
      }else{
        return photosRef.child('photo1').set(photoUrl);
      }
    });
  }

  Future<void> deletePicture(id, url) async {
    final petRef = _database.reference()
      .child('pets')
      .child(id)
      .child('photos');
    String key;
    await petRef.once().then((snapshot) {
      final Map urlMap = snapshot.value;
      key = urlMap.keys.firstWhere((key) => urlMap[key] == url);
    });
    petRef.child(key).remove();
    Reference reference = _storage.refFromURL(url);
    await reference.delete();
  }

  Future<List<PetModel>> searchPet(String query) async {
    final petsRef = _database.reference()
      .child("pets")
      .orderByChild('name')
      .startAt(query.toUpperCase())
      .endAt('${query.toLowerCase()}\uf8ff');

    return await petsRef.once().then((snapshot) {
      if(snapshot.value == null) {
        return List();
      } else {
        final toRemove = [];
        snapshot.value.forEach((key, value) {
          if(value['ownerId'] == _auth.currentUser.uid){
            toRemove.add(key);
          }
        });
        toRemove.forEach((element) => snapshot.value.remove(element));
        return PetsList().fromJSON(snapshot.value);
      }
    });
  }

  Future<String> _uploadImage(File image) async {
    Reference storageReference =
        _storage.ref().child('profile/${Path.basename(image.path)}');
    
    File newImage = await _compress(image);
    
    UploadTask uploadTask = storageReference.putFile(newImage);

    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }

  Future<File> _compress(File image) async {
    return await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      image.absolute.path.substring(0,image.absolute.path.length - 5) + ".jpg",
      quality: 40
    );
  }
}