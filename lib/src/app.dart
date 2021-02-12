import 'package:flutter/material.dart';

import 'package:zooland/src/pages/auth/auth_page.dart';
import 'package:zooland/src/pages/home/chat/chat_page.dart';
import 'package:zooland/src/pages/home/home_page.dart';
import 'package:zooland/src/pages/home/news/add_news_page.dart';
import 'package:zooland/src/pages/home/news/edit_news_page.dart';
import 'package:zooland/src/pages/home/profile/add_pet_page.dart';
import 'package:zooland/src/pages/home/profile/edit_pet_page.dart';
import 'package:zooland/src/pages/home/profile/edit_profile_page.dart';
import 'package:zooland/src/pages/home/profile/see_profile_page.dart';
import 'package:zooland/src/pages/main_page.dart';

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
          return MainPage();
        },
        '/authentication': (context) {
          return AuthPage();
        },
        '/add-news': (context) {
          return AddNewsPage();
        },
        '/edit-news': (context) {
          return EditNewsPage();
        },
        '/update-profile': (context) {
          return EditProfilePage();
        },
        '/add-pet': (context) {
          return AddPetPage();
        },
        '/update-pet': (context) {
          return EditPetPage();
        },
        '/see-profile': (context) {
          return SeeProfilePage();
        },
        '/chat': (context) {
          return ChatPage();
        } 
      },
    );
  }
}
