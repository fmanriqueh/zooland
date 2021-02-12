import 'package:flutter/material.dart';

import 'package:zooland/src/models/news_model.dart';
import 'package:zooland/src/pages/home/news/forms/edit_news_form.dart';

class EditNewsPage extends StatefulWidget {
  EditNewsPage({Key key}) : super(key: key);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  @override
  Widget build(BuildContext context) {
    final NewsModel newsModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar evento"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Evento",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      EditNewsForm(newsModel: newsModel)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
