import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:questbook/Goggle_Login.dart';

import 'UserInfoGlaf.dart';
import 'firebasebig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  InAppPurchaseConnection.enablePendingPurchases();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(HomeS());
  });
}

class HomeS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return StreamProvider<UserInfotoo>.value(
                value: Google_logIn().currentUser,
                child: MaterialApp(
                  home: Autorization(),
                ));
          }
        });
  }
}

class Autorization extends StatelessWidget {
  const Autorization({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    final bool isLoginIn = userFireBase != null;
    return isLoginIn ? FirebaseBunt() : Google_logIn();
  }
}
