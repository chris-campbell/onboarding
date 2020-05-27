import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FirebaseService {

  Future getDisplayName() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.displayName;
  }

  Future signout() async {
    await _firebaseAuth.signOut();
  }

}