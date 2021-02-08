import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'UserInfoGlaf.dart';

class Google_logIn extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isFacebookLoginIn = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Center(
            child: InkWell(
              onTap: () {
                onGoogleSignIn(context);
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(height * 100),
                ),
                child: Center(
                  child: Text("Google"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<User> _handleSignIn() async {
    User user;
    bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await auth.signInWithCredential(credential)).user;
    }
    return user;
  }

  Future<UserInfotoo> onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    if (user.uid != null) {
      final firestore = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (firestore.data() == null) {
        print("не существует документа ");
        final firestore = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          "key": 0,
          "diamonds": 0,
          "language": 'ru',
          "onClickMesseng": 'on',
          "onClickMusic": 'on',
          "spin": 0
        });
      } else {
        print('Пользователь существует');
      }

      //     .then((value) async {
      //   value.documents.forEach((result) {
      //     if (result.documentID == user.uid) {
      //       count = 1;
      //     } else {
      //       count = 0;
      //     }
      //   });
      //   if (count == 1) {
      //     print('Пользователь  сушествует ');
      //   } else {
      //     print("не существует документа ");
      //     final firestore = await Firestore.instance
      //         .collection('users')
      //         .document(user.uid)
      //         .setData({
      //       "key": 0,
      //       "diamonds": 0,
      //       "language": 'ru',
      //       "onClickMesseng": 'on',
      //       "onClickMusic": 'on',
      //       "spin": 0
      //       // "nameHero": '',
      //       // "nameAnimal": '',
      //     });
      //   }
      // });

      return UserInfotoo.fromFirebase(user);
    } else {}
  }

  Future logOt() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  Stream<UserInfotoo> get currentUser {
    return auth.authStateChanges().map((
          User user,
        ) =>
            user != null ? UserInfotoo.fromFirebase(user) : null);
  }
}
