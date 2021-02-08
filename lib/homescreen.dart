import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authscreen.dart';

class Home extends StatefulWidget {
  final String username;
  Home({Key key, @required this.username}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello " + widget.username),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await googleSignIn.disconnect();
              await googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Log Out"),
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
