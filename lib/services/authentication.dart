import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  static Future<UserCredential?> signUp({
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
          // Add more fields as needed
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up with email and password: ${e.message}');
      return null;
    }
  }

  // Sign in with email and password
  static Future<UserCredential?> signIn({
    required String email, 
    required String password
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with email and password: ${e.message}');
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
