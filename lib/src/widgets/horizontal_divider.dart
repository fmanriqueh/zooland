import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key key, this.text = '-', this.height = 36.0}) : super(key: key);

  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Divider(
              color: Colors.black26,
              height: height,
            )
          ),
        ),
        Text(
          '${text}',
          style: TextStyle(
            fontWeight: FontWeight.w400
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Divider(
              color: Colors.black26,
              height: height,
            )
          ),
        ),
      ]
    );
  }
}