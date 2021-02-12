import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:zooland/src/app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zooland/src/widgets/activity_indicator.dart';


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
          return Center(child: Text("Algo salió mal..."),);
        }
        return ActivityIndicator();
      },
    );
  }
}
