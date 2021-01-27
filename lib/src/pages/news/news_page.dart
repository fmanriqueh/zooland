import 'package:flutter/cupertino.dart';
import 'package:zooland/src/providers/api_provider.dart';

import 'package:zooland/src/widgets/news.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ApiProvider _apiProvider = ApiProvider.instance;
    _apiProvider.fetchNews();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      children: [
        News(),
      ],
    );
  }
}