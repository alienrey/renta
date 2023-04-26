import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renta/models/renta/User.dart';

class FirebaseUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<UserData> getUserData(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    print(doc.data());
    return UserData.fromDocumentSnapshot(doc);
  }

  Future<void> updateUserData(String uid, UserData data) async {
    await _db.collection('users').doc(uid).set(data.toMap());
  }
}
