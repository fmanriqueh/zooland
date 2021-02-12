import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:zooland/src/pages/auth/auth_page.dart';
import 'package:zooland/src/pages/home/home_page.dart';
import 'package:zooland/src/widgets/activity_indicator.dart';
import 'package:zooland/src/widgets/error_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting ) {
          return ActivityIndicator();
        } else if(snapshot.connectionState == ConnectionState.active ) {
          if(snapshot.data == null) {
            return AuthPage();
          } else {
            return HomePage();
          }
        } else {
          return ErrorIdicator();
        }
      }
    );
  }
}