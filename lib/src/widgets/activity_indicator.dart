import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Container(
        color: Colors.transparent,
        child: CupertinoActivityIndicator(
          radius: 15,
        )
      )
    );
  }
}