import 'package:flutter/material.dart';

import 'package:zooland/src/pages/news/news_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentBottomTap = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: WillPopScope(
          child: PageView(
            children: [
              NewsPage()
            ],
          ),
          onWillPop: _onWillPop,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomTap,
        onTap: (int index){
          setState(() {
            _currentBottomTap = index;
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

  Future<bool> _onWillPop() async{
    if(_pageController.page.round() == _pageController.initialPage){
      return true;
    }else{
      _pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.fastOutSlowIn);
      return false;
    }
  }
}