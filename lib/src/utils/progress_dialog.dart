import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProgressDialog {
  Future<User> showProgressLogin({BuildContext context, Future future}) {
    future.then((value) {
      if (value == null) {
        Navigator.pop(context);
      } else {
        _dismiss(context);
      }
      return value;
    });
    _show(context);
  }

  Future<User> showProgress({BuildContext context, Future future}) {
    future.then((value) {
      Navigator.pop(context);
      return value;
    });
    _show(context);
  }

  Future<void> showProgressAndGoBack({BuildContext context, Future future}) {
    future.then((value) {
      _dismiss(context);
    });
    _show(context);
  }

  Future<void> showProgressNormal({BuildContext context, Future future}) {
    future.then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
    _show(context);
  }

  void _show(BuildContext context) {
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

  void _dismiss(BuildContext context) {
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, '/');
  }
}
