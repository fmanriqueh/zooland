import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import 'package:zooland/src/resources/auth.dart';

import '../models/news_model.dart';
import '../models/news_model.dart';

class NewsProvider {
  NewsProvider._internal();
  static final NewsProvider instance = NewsProvider._internal();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<NewsModel>> fetchNews() async {
    return await _database.reference().child('news').orderByChild('date').once().then(
      (snapshot) {
        if(snapshot.value == null) {
          return List();
        }
        return NewsList().fromJSON(snapshot.value);
      }
    );
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

    final newsRef = _database.reference().child("news").child(Uuid().v4()).child('data');
    return newsRef.set(_newsModel.toJson());
  }

  Future<void> removeNews(id) async {
    final newsRef = _database.reference().child("news").child(id);
    final imgUrlRef = newsRef.child('data').child('imgUrl');
    
    imgUrlRef.once().then((snapshot) async {
      Reference reference = _storage.refFromURL(snapshot.value);
        await reference.delete();
    });
    newsRef.child('data').remove();
    newsRef.child('likes').remove();
    newsRef.child('attendances').remove();
  }

  Future<void> updateNews({
      @required String id,
      @required String headline,
      @required String summary,
      @required String date,
      @required String place
    }) {
      final newsRef = _database.reference().child('news').child(id).child('data');
      return newsRef.update({
        headline == '' ? '': 'headline' : headline,
        summary  == '' ? '': 'summary'  : summary,
        date     == '' ? '': 'date'     : date,
        place    == '' ? '': 'type'     : place,
      });
  }

  Stream<Event> subscribeNews(){
    final newsRef = _database.reference().child("news");
    return newsRef.onChildRemoved;
  }

  Stream<Event> subscribeLike(id) {
    final newsLikeRef = _database.reference()
      .child("news")
      .child(id)
      .child("likes")
      .child(_auth.currentUser.uid);
    return newsLikeRef.onValue;
  }

    Stream<Event> subscribeAttendance(id) {
    final newsLikeRef = _database.reference()
      .child("news")
      .child(id)
      .child("attendances")
      .child(_auth.currentUser.uid);
    return newsLikeRef.onValue;
  }

  Future<bool> fetchLike(id) {
    final newsLikeRef = _database.reference()
      .child("news")
      .child(id)
      .child("likes")
      .child(_auth.currentUser.uid);
    return newsLikeRef.once().then((snapshot){
      return snapshot.value;
    });
  }

  Future<bool> fetchAttendance(id) {
    final newsLikeRef = _database.reference()
      .child("news")
      .child(id)
      .child("attendances")
      .child(_auth.currentUser.uid);
    return newsLikeRef.once().then((snapshot){
      return snapshot.value;
    });
  }

  Future<void> addOrRemoveLike(id){
    final newsLikeRef = _database.reference()
      .child("news")
      .child(id)
      .child("likes")
      .child(_auth.currentUser.uid);
      newsLikeRef.once().then((snapshot) {
        if(snapshot.value != null) {
          newsLikeRef.remove();
        } else {
          newsLikeRef.set(true);
        }
      });
  }

  Future<void> addOrRemoveAttendances(id){
    final newsAttendanceRef = _database.reference()
      .child("news")
      .child(id)
      .child("attendances")
      .child(_auth.currentUser.uid);
      newsAttendanceRef.once().then((snapshot) {
        if(snapshot.value != null) {
          newsAttendanceRef.remove();
        } else {
          newsAttendanceRef.set(true);
        }
      });
    
  }

  Future<String> _uploadImage(File _image) async {
    Reference storageReference =
        _storage.ref().child('news/${Path.basename(_image.path)}');

    UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }
}
