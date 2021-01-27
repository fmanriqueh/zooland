import 'package:flutter/material.dart';

import 'package:zooland/src/models/news_model.dart';

class News extends StatelessWidget {
  const News({Key key, @required this.newsModel}) : super(key: key);

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:20, bottom:20),
      child: Container(
        height: 320,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          elevation: 4,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: 500, 
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/loading.gif'),
                      image: NetworkImage('https://images.unsplash.com/photo-1611550368494-923f95388437?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}