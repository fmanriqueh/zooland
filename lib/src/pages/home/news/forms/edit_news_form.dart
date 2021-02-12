import 'package:flutter/material.dart';
import 'package:zooland/src/models/news_model.dart';

import 'package:zooland/src/providers/news_provider.dart';
import 'package:zooland/src/utils/progress_dialog.dart';
import 'package:zooland/src/widgets/custom_text_form_field.dart';
import 'package:zooland/src/widgets/date_form_field.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class EditNewsForm extends StatefulWidget {
  const EditNewsForm({Key key, @required this.newsModel}) : super(key: key);

  final NewsModel newsModel;

  @override
  _EditNewsFormState createState() => _EditNewsFormState();
}

class _EditNewsFormState extends State<EditNewsForm> {
  NewsProvider _newsProvider = NewsProvider.instance;

  final _formKey = GlobalKey<FormState>();
  final _headlineKey = GlobalKey<CustomTextFormFieldState>();
  final _summaryKey = GlobalKey<CustomTextFormFieldState>();
  final _placeKey = GlobalKey<CustomTextFormFieldState>();
  final _dateKey = GlobalKey<DateFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              key: _headlineKey,
              text: widget.newsModel.headline,
              hint: "Título del evento"
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _summaryKey,
              text: widget.newsModel.summary,
              hint: "Descripción"
            ),
            SizedBox(height: 15.0),
            CustomTextFormField(
              key: _placeKey,
              text: widget.newsModel.place,
              hint: "Lugar"
            ),
            SizedBox(height: 15.0),
            DateFormField(
              key: _dateKey,
              text: widget.newsModel.date,
              hint: "Fecha del evento",
            ),
            SizedBox(height: 15.0),
            RoundedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    ProgressDialog().showProgressAndGoBack(
                      context: context,
                      future: _newsProvider.updateNews(
                        id: widget.newsModel.uid,
                        headline: _headlineKey.currentState.value,
                        summary: _summaryKey.currentState.value,
                        date: _dateKey.currentState.value,
                        place: _placeKey.currentState.value
                      )
                    );
                  }
                })
          ],
        ));
  }
}
