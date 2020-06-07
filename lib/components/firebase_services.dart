import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FirebaseService {
  Future getDisplayName() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.displayName;
  }

  Future logoutUser() async {
    return await _firebaseAuth.signOut();
  }

  void logoutNotification(scaffoldKeySetup) {
    scaffoldKeySetup.currentState.showSnackBar(SnackBar(
      content: Text('You have successfully signed out'),
    ));
  }
}
