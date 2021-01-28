import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zooland/src/providers/api_provider.dart';

import 'package:zooland/src/widgets/news.dart';

import '../../providers/news_provider.dart';
import '../../resources/auth.dart';
import '../../widgets/rounded_button.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsProvider _newsProvider = NewsProvider.instance;
    _newsProvider.fetchNews();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add-news');
              },
              child: Text("Agregar evento"),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            ),
          ],
        ),
        News(),
        RoundedButton(
            onPressed: () {
              Auth.instance.signOut();
              Navigator.of(context).popAndPushNamed('/');
            },
            child: Text("Salir"))
      ],
    );
  }
}
