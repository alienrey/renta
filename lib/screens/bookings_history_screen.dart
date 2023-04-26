import 'package:flutter/material.dart';
import 'package:renta/components/active_booking_component.dart';
import 'package:renta/models/active_bookings_model.dart';
import 'package:renta/models/renta/Booking.dart';
import 'package:renta/services/BookingService.dart';
import 'package:renta/utils/constant.dart';

class BookingsHistoryScreen extends StatefulWidget {
  const BookingsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingsHistoryScreen> createState() => _BookingsHistoryScreenState();
}

class _BookingsHistoryScreenState extends State<BookingsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Booking>>(
        future: FirebaseBookingService().getMyBookings(),
        builder: (BuildContext context, AsyncSnapshot<List<Booking>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("No Data"));
          } else {

            final activeRents = snapshot.data!.where((element) => element.bookingStatus == completed).toList();
            if(activeRents.isEmpty) return Center(child: Text("No Data"));

            return ListView.builder(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 16),
              itemCount: activeRents.length,
              itemBuilder: (BuildContext context, int index) {
                return ActiveBookingComponent(booking: activeRents[index]);
              },
            );
          }
        },
      ),

    );
  }
}
