import 'package:flutter/material.dart';
import 'package:zooland/src/pages/auth/auth_page.dart';
import 'package:zooland/src/pages/home_page.dart';
import 'package:zooland/src/pages/news/add_news_page.dart';
import 'package:zooland/src/resources/auth.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zooland',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) {
          if (Auth.instance.user != null) {
            return HomePage(
              title: 'Zooland',
            );
          } else {
            return AuthPage();
          }
        },
        '/home': (context) {
          return HomePage(title: 'Logged');
        },
        '/add-news': (context) {
          return AddNewsPage();
        }
      },
    );
  }
}
