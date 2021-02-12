import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zooland/src/models/news_model.dart';
import 'package:zooland/src/providers/news_provider.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/activity_indicator.dart';
import 'package:zooland/src/widgets/error_indicator.dart';
import 'package:zooland/src/widgets/news_card.dart';
import 'package:zooland/src/widgets/rounded_button.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Auth.instance.isAdmin(),
      builder: (_, snapshot) {
        if(snapshot.hasData) {
          return _getNews(isAdmin: snapshot.data);
        } else if(snapshot.hasError) {
          return ErrorIdicator();
        }
        return ActivityIndicator();
      },
    );
  }

  _getNews({bool isAdmin}) {
    return StreamBuilder<Object>(
      stream: NewsProvider.instance.subscribeNews(),
      builder: (context, snapshot) {
        return FutureBuilder(
          future: NewsProvider.instance.fetchNews(),
          builder: (_, snapshot) {
            if(snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.only(left:10.0, right:10.0),
                children: [
                  if(isAdmin) _addNewsButton(),
                  _getNewsItems(news: snapshot.data, isAdmin: isAdmin)
                ],
              );
            } else if(snapshot.hasError) {
              return ErrorIdicator();
            }
            return ActivityIndicator();
          }
        );
      }
    );
  }

  _addNewsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RoundedButton(
          child: Text('Agregar evento'),
          onPressed: () => Navigator.of(context).pushNamed('/add-news'),
        ),
      ],
    );
  }

  _getNewsItems({List<NewsModel> news, bool isAdmin}){
    return  ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsCard(
          newsModel: news[index],
          isAdmin: isAdmin,
        );
      }
    );
  }
}
