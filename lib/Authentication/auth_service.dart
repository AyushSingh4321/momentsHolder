import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // User cancels sign-in in the pop-up screen
      if (gUser == null) return null;

      // Obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally sign in!
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user; // Return the signed-in user
    } catch (e) {
      print("Error in Google Sign-In: $e");
      return null; // Return null on failure
    }
  }
}
