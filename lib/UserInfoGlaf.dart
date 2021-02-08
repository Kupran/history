import 'package:firebase_auth/firebase_auth.dart';

class UserInfotoo {
  String uid;
  FirebaseAuth firebaseAuth;
  int diamonds;
  int coins;

  UserInfotoo.fromFirebase(User user) {
    uid = user.uid;
  }
  UserInfotoo.from(int coins) {
    this.coins = coins;
  }
}
