import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  Auth._internal();
  static final Auth instance = Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user => _firebaseAuth.currentUser;

  Future<User> signupWithEmailAndPassword(BuildContext context,
      {@required String name,
      @required String email,
      @required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user.updateProfile(displayName: name);
        _saveUser(userCredential.user, name);
        return userCredential.user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Contraseña débil")));
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Cuenta asociada a este correo")));
      }
    } catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Algo salió mal")));
    }
  }

  Future<User> loginWithEmailAndPassword(BuildContext context,
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Este usuario no se encuentra registrado.")));
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Credenciales inválidas.")));
      }
    }
  }

  Future<User> loginWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  /*Future<User> loginWithFacebook(BuildContext context) async {
    final AccessToken accessToken = await FacebookAuth.instance.login();

    final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(accessToken.token);

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    return userCredential.user;
  }*/

  Future<bool> checkAdmin(BuildContext context) {
    print(_database.reference().child('admins').child(this.user.uid));
  }

  Future<void> resetPassword(BuildContext context,
      {@required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Scaffold.of(context).showSnackBar(SnackBar(
          content:
              Text("Se ha enviado un correo para restablecer tu contraseña.")));
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Este usuario no se encuentra registrado.")));
      }
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  void _saveUser(User user, String name) {
    Map<String, dynamic> userData = {
      "name": name,
      "email": user.email,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch
    };

    final userRef = _database.reference().child("users").child(user.uid);
    userRef.set(userData);
  }
}
