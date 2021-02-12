import 'package:flutter/material.dart';

import 'package:zooland/src/pages/home/match/match_page.dart';
import 'package:zooland/src/pages/home/news/news_page.dart';
import 'package:zooland/src/pages/home/profile/profile_page.dart';
import 'package:zooland/src/utils/pet_search_delegate.dart';
import 'package:zooland/src/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBottomTap = 0;

  NewsPage _newsPage;
  MatchPage _matchPage;
  ProfilePage _profilePage;
  List<Widget> _pages;
  Widget _currentPage;

  final Key _newsPageKey    = PageStorageKey('newsPage');
  final Key _matchPageKey   = PageStorageKey('matchPage');
  final Key _profilePageKey = PageStorageKey('profilePage');
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    _newsPage = NewsPage(key: _newsPageKey);
    _matchPage = MatchPage(key: _matchPageKey);
    _profilePage = ProfilePage(key: _profilePageKey);
    _pages = [_newsPage, _matchPage, _profilePage];
    _currentPage = _newsPage;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentBottomTap == 1 ? 
        AppBar(title: SearchField(searchFildLabel: 'Buscar mascota', searchDelegate: PetSearchDelegate('Buscar mascota')))
        :null,
      body:  PageStorage(
        child: SafeArea(child: _currentPage),
        bucket: _bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomTap,
        onTap: (int index) {
          setState(() {
            _currentBottomTap = index;
            _currentPage      = _pages[index];
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "Noticias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Emparejar"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil"
          )
        ]
      ),
    );
  }
}
