import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

import '../models/news_model.dart';
import '../models/news_model.dart';

class NewsProvider {
  NewsProvider._internal();
  static final NewsProvider instance = NewsProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> fetchNews() async {
    _database.reference().child('news').once().then((snapshot) {
      print("l");
      print(snapshot.value);
    });
  }

  Future<void> addNews(
      {@required String headline,
      @required String summary,
      @required String date,
      @required String place,
      @required File image}) async {
    String imgUrl = await _uploadImage(image);
    NewsModel _newsModel = NewsModel(
        headline: headline,
        summary: summary,
        date: date,
        place: place,
        imgUrl: imgUrl);

    final newsRef = _database.reference().child("news").child(Uuid().v4());
    return newsRef.set(_newsModel.toJson());
  }

  Future<String> _uploadImage(File _image) async {
    Reference storageReference =
        _storage.ref().child('profile/${Path.basename(_image.path)}');

    UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }
}
