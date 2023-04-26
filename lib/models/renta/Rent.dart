class Booking {
  String itemId;
  String renterId;
  DateTime rentDate;
  DateTime returnDate;
  bool isReturned;
  double extraCharges;

  Booking({
    required this.itemId,
    required this.renterId,
    required this.rentDate,
    required this.returnDate,
    required this.isReturned,
    required this.extraCharges,
  });

  // Factory method to create Rental object from a Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      itemId: map['itemId'],
      renterId: map['renterId'],
      rentDate: DateTime.parse(map['rentDate']),
      returnDate: DateTime.parse(map['returnDate']),
      isReturned: map['isReturned'],
      extraCharges: map['extraCharges'],
    );
  }

  // Method to convert Rental object to a Map
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'renterId': renterId,
      'rentDate': rentDate.toIso8601String(),
      'returnDate': returnDate.toIso8601String(),
      'isReturned': isReturned,
      'extraCharges': extraCharges,
    };
  }
}
