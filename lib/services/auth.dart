import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Firebase auth instance with user id and email
final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? userEmail;

class AuthClient {
  //Register with email and password
  Future<User?> register(String name, String email, String password) async {
    await Firebase.initializeApp();
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      user = _auth.currentUser;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint(
            'An account with the specified email already exists. Try a different email');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return user;
  }

  // Login method
  Future<User?> login(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {} on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user with specified email exists');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return user;
  }

  // Sign out method
  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    uid = null;
    userEmail = null;

    return 'User signed out';
  }
}
