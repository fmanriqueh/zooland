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

  Map<String, int> _pages = {
    "loginPage" : 0,
    "signupPage": 1,
    "forgotPage": 2
  };

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
                  onGoToSignup: () => _switchPage(_pages['signupPage']),
                  onGoToForgot: () => _switchPage(_pages['forgotPage']),
                ),
                SignupPage(
                  onGoToLogin: () => _switchPage(_pages['loginPage']),
                ),
                ForgotPage(
                  onGoToLogin: () => _switchPage(_pages['loginPage']),
                )
              ],
            ),
            onWillPop: () => _onWillPop(),
          ),
        ),
      )
    );
  }

  void _switchPage(int page){
    _pageController.jumpToPage(page);
  }

  Future<bool> _onWillPop() async{
    if(_pageController.page.round() == _pageController.initialPage){
      return true;
    }else{
      _pageController.jumpToPage(_pages['loginPage']);
      return false;
    }
  }
}