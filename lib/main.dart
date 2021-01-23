import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:zooland/src/app.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return App();
        }else if(snapshot.hasError){
          return Center(child: Text("Something went wrong"),);
        }
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: CupertinoActivityIndicator(
              radius: 15
            )
          )
        );

        
        /*return Center(
          child: CircularProgressIndicator(),
        );*/
      },
    );
  }
}
