import 'package:flutter/material.dart';
import 'package:zooland/src/pages/auth/forgot_page.dart';

import 'package:zooland/src/pages/auth/login_page.dart';
import 'package:zooland/src/pages/auth/signup_page.dart';


class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

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
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: WillPopScope(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                LoginPage(
                  onGoToSignup: () => _switchForm(1),
                  onGoToForgot: () => _switchForm(2),
                ),
                SignupPage(
                  onGoToLogin: () => _switchForm(0),
                ),
                ForgotPage(
                  onGoToLogin: () => _switchForm(0),
                )
              ],
            ),
            onWillPop: () => _onWillPop(),
          ),
        ),
      )
    );
  }

  void _switchForm(int page){
    _pageController.animateToPage(page, duration: Duration(milliseconds:1), curve: Curves.fastOutSlowIn);
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

/*
GestureDetector(


Stack(
          children: [Container(
padding: EdgeInsets.all(18),
child: Center(
  child: WillPopScope(
    child: PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        ListView(
                              children: [LoginPage(
            onGoToForgot: (){
              _switchForm(2);
            },
            onGoToSignup: (){
              _switchForm(1);
            },
          ),]
        ),
        SignupPage(),
        ForgotPage()
      ],
    ),
    onWillPop: () => _onWillPop(),
  ),
),
),]
),

*/