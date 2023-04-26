import 'package:renta/models/renta/Rentals.dart';

class Booking {
  String id;
  String itemId;
  String renterId;
  DateTime rentDate;
  DateTime returnDate;
  String bookingStatus;
  bool isCompleted;
  double extraCharges;
  Rental item; // new field

  Booking({
    required this.id,
    required this.itemId,
    required this.renterId,
    required this.rentDate,
    required this.returnDate,
    required this.bookingStatus,
    required this.isCompleted,
    required this.extraCharges,
    required this.item, // include in constructor
  });

  // Factory method to create Booking object from a Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      itemId: map['itemId'],
      renterId: map['renterId'],
      rentDate: DateTime.parse(map['rentDate']),
      returnDate: DateTime.parse(map['returnDate']),
      bookingStatus: map['bookingStatus'],
      isCompleted: map['isCompleted'],
      extraCharges: map['extraCharges'],
      item: Rental.fromMap(map['item']), // map to Rental object
    );
  }

  // Method to convert Booking object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'renterId': renterId,
      'rentDate': rentDate.toIso8601String(),
      'returnDate': returnDate.toIso8601String(),
      'bookingStatus': bookingStatus,
      'isCompleted': isCompleted,
      'extraCharges': extraCharges,
      'item': item.toMap(), // convert Rental object to map
    };
  }
}
