import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renta/models/renta/Booking.dart';

class FirebaseBookingService {
  final CollectionReference bookingsCollection = FirebaseFirestore.instance.collection('bookings');
  final User? _user = FirebaseAuth.instance.currentUser;

  // Create a new booking
    Future<void> addBooking(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await bookingsCollection.add(data);
      await doc.set({...data, "id": doc.id});
    } catch (e) {
      print('Error creating booking: $e');
      throw e;
    }
  }

  // Update an existing booking
  Future<void> updateBooking(Booking booking) {
    return bookingsCollection.doc(booking.id).update(booking.toMap());
  }

  // Delete a booking
  Future<void> deleteBooking(String id) {
    return bookingsCollection.doc(id).delete();
  }

  // Get all bookings for the current user
  Future<List<Booking>> getMyBookings() async {
    final snapshot = await bookingsCollection
        .where('renterId', isEqualTo: _user!.uid)
        .get();
    final bookings = snapshot.docs.map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>)).toList();
    return bookings;
  }

   Future<List<Booking>> getMyActiveListings() async {
    final snapshot = await bookingsCollection
        .where('item.ownerId', isEqualTo: _user!.uid)
        .get();
    final bookings = snapshot.docs.map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>)).toList();
    return bookings;
  }

}
