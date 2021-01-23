import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key key, @required this.context, @required this.future}) : super(key: key);

  final Future future;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot){
        if(snapshot.hasData){
          print('solved');
          Scaffold.of(context).showSnackBar(SnackBar(content:Text("Logged")));
          Navigator.pop(context);
        }else if(snapshot.hasError){
          Scaffold.of(context).showSnackBar(SnackBar(content:Text("Uhmmm")));
          Navigator.pop(context);
        }
        showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.7),
            child: CupertinoActivityIndicator(
              radius: 15,
            ),
          )
        );
      }
    );
  }
}