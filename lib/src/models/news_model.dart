import 'package:uuid/uuid.dart';

class NewsList {
  List<NewsModel> newsList;

  NewsList({this.newsList});
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

  Map<String, dynamic> toJson() => {
        'headline': this.headline,
        'summary': this.summary,
        'imgUrl': this.imgUrl,
        'place': this.place,
        'date': this.date
      };
}
