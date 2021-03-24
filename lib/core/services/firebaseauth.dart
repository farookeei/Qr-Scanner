import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'dependecyInjection.dart';

class FirebaseAuthEmail {
  FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  Future<User> emailAndPasswordSignIn(
      {@required String email,
      @required String password,
      bool isEmailVerificationNeeded = false}) async {
    try {
      print("dsfasf");
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User _user = _firebaseAuth.currentUser;

      print("|dfadsfasf");
      if (isEmailVerificationNeeded) {
        if (!_user.emailVerified) {
          await _user.sendEmailVerification();
        }
      }

      return _firebaseAuth.currentUser;
    } catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
  }

  Future<User> emailAndPasswordSignUp(
      {@required String email,
      @required String password,
      bool isEmailVerificationNeeded = false}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User _user = _firebaseAuth.currentUser;

      if (isEmailVerificationNeeded) {
        if (!_user.emailVerified) {
          await _user.sendEmailVerification();
        }
      }

      return _firebaseAuth.currentUser;
    } catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
