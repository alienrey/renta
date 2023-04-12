import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String profilePicture;

  UserData({required this.profilePicture, required this.firstName, required this.lastName, required this.email, required this.phoneNumber});

  // Deserialize from JSON
  // Deserialize from DocumentSnapshot
  factory UserData.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      profilePicture: snapshot['profilePicture'],
    );
  }

  // Serialize to Map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture
    };
  }
}
