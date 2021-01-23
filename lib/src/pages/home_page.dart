import 'package:flutter/material.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/rounded_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentBottomTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Yeison Manrique H"),
            RoundedButton(
              onPressed: () async {
                await Auth.instance.signOut();
                Navigator.popAndPushNamed(context, '/');
              }, child: Text('Sign out'))
          ]
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
}