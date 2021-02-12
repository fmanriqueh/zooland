import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class NewsList {
  List<NewsModel> _newsList;

  List<NewsModel> fromJSON(news){
    _newsList = List();
    news.forEach((uid, data) {
      _newsList.add(NewsModel().fromJson(uid, data['data']));
    });
    return _newsList;
  }
}

class NewsModel {
  String headline;
  String summary;
  String imgUrl;
  String place;
  String uid;
  String date;

  NewsModel(
      {this.headline,
      this.summary,
      this.imgUrl,
      this.place,
      this.date,
      this.uid});

  NewsModel fromJson(uid, news) {
    this.headline = news['headline'];
    this.summary = news['summary'];
    this.place = news['place'];
    this.imgUrl = news['imgUrl'];
    this.date = news['date'];
    this.uid = uid;
    return this;
  }

  Map<String, dynamic> toJson() => {
    'headline': this.headline,
    'summary': this.summary,
    'imgUrl': this.imgUrl,
    'place': this.place,
    'date': this.date
  };
}
