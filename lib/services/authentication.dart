import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renta/models/renta/User.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  static Future<UserCredential?> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        // Create user profile in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phoneNumber': phoneNumber,
          'profilePicture': 'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1-800x800.jpg'
          // Add more fields as needed
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up with email and password: ${e.message}');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "${e.message}",
        )
      );
      return null;
    }
  }

  // Sign in with email and password
  static Future<UserData?> signIn({required BuildContext context, required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userCredential.user?.uid).get();
      UserData user = UserData.fromDocumentSnapshot(snapshot);
      return user;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with email and password: ${e.message}');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "${e.message}",
        )
      );
      return null;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Get the currently signed-in user
  static User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Get the ID of the currently signed-in user
  static String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  // Check if the user is signed in
  static bool isSignedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
