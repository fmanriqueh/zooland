import 'package:flutter/material.dart';

class ErrorIdicator extends StatelessWidget {
  const ErrorIdicator({Key key, this.message = 'Algo salió mal...'}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message)
    );
  }
}