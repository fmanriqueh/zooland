import 'dart:io';
import 'package:path/path.dart' as Path;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zooland/src/models/profile_model.dart';

class ProfileProvider {
  ProfileProvider._internal();
  static final ProfileProvider instance = ProfileProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ProfileModel> fetchProfile(uid) async {
    final profileRef = _database.reference()
      .child("users")
      .child(uid);
    return await profileRef.once().then((snapshot) {
      return ProfileModel().fromJson(snapshot.value);
    });
  }

  Future<void> addPicture(File image) async {
    String pictureUrl = await _uploadImage(image);
    final pictureRef = _database.reference()
      .child("users")
      .child(_auth.currentUser.uid)
      .child("pictureUrl");
    pictureRef.once().then((snapshot) async {
      if(snapshot.value != null) {
        Reference reference = _storage.refFromURL(snapshot.value);
        await reference.delete();
      }
      pictureRef.set(pictureUrl);
    });
  }

  Future<void> updateProfile({
    String name,
    String location
  }){
    final profileRef = _database.reference()
      .child("users")
      .child(_auth.currentUser.uid);
      return profileRef.update({
        name     == '' ? '' : "name"     : name,
        location == '' ? '' : "location" : location
      });
  }

  Stream<Event> subscribeProfile(){
    final profileRef = _database.reference()
          .child("users")
          .child(_auth.currentUser.uid);
    return profileRef.onChildChanged;
  }

  Stream<Event> subscribePets(){
    final profileRef = _database.reference()
          .child("pets")
          .orderByChild('ownerId')
          .equalTo(_auth.currentUser.uid);
    return profileRef.onChildAdded;
  }

  Future<String> _uploadImage(File image) async {
    Reference storageReference =
        _storage.ref().child('profile/${Path.basename(image.path)}');

    UploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }
}