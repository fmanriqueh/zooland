import 'package:flutter/material.dart';
import 'package:zooland/src/pages/news/forms/add_news_form.dart';

class AddNewsPage extends StatefulWidget {
  AddNewsPage({Key key}) : super(key: key);

  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar evento"),
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
                        "Nuevo evento",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      AddNewsForm()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
