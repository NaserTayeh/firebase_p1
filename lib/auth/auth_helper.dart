// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } on Exception catch (e) {
      // TODO
      AppRouter.appRouter
          .showCustomDialooug('Error in regestration', e.toString());
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid; // return info for last user sign in

      log('success');
    } on Exception catch (e) {
      AppRouter.appRouter
          .showCustomDialooug('Error in Authentication', e.toString());
      // TODO
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  resetPassword(String email) async {}
  verifyEmail(String email) async {}
  String? checkUser() {
    User? user = firebaseAuth.currentUser;
    return user?.uid;
  }
}
