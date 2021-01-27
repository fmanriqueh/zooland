import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ApiProvider{
  
  ApiProvider._internal();
  static final ApiProvider instance = ApiProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> fetchNews() async {
    _database.reference().child('news').orderByKey().once().then((snapshot){
      snapshot.value.forEach((e) => print(e));
    });
  }

  

  /*void _getUsers() {
    FirebaseDatabase _database = FirebaseDatabase.instance;
    _database.reference().child('users').once().then((snapshot) {
      print(snapshot.value);
    });
  }*/

} 