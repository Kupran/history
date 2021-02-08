import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeUserWidget extends StatelessWidget {
  GoogleSignIn _googleSignIn;
  FirebaseAuth firebaseAuth;
  User _user;

  WelcomeUserWidget(User user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipOval(
              child: Image.network(_user.phoneNumber,
                  width: 100, height: 100, fit: BoxFit.cover)),
          Text(_user.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          FlatButton(
              child: Text("Выход"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                _googleSignIn.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
