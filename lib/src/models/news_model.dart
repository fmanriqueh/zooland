class NewsList {
  List<NewsModel> newsList;

  NewsList({this.newsList});
}

class NewsModel {

  String headline;
  String summary;
  String img;
  String place;
  String uid;
  DateTime date;

  NewsModel({this.headline, this.summary, this.img, this.place, this.date, this.uid});

  Map<String, dynamic> toJson() => {
    'headline': this.headline,
    'summary': this.summary,
    'img': this.img,
    'place': this.place,
    'date': this.date
  };
}