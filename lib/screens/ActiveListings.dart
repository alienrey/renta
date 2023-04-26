import 'package:flutter/material.dart';
import 'package:renta/components/active_booking_component.dart';
import 'package:renta/components/active_listing_component.dart';
import 'package:renta/models/renta/Booking.dart';
import 'package:renta/services/BookingService.dart';
import 'package:renta/utils/constant.dart';

class ActiveListings extends StatefulWidget {
  const ActiveListings({Key? key}) : super(key: key);

  @override
  State<ActiveListings> createState() => _ActiveListingsState();
}

class _ActiveListingsState extends State<ActiveListings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Booking>>(
        future: FirebaseBookingService().getMyActiveListings(),
        builder: (BuildContext context, AsyncSnapshot<List<Booking>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("No Data"));
          } else {

            final activeRents = snapshot.data!.where((element) => element.bookingStatus == pending || element.bookingStatus == renting).toList();

            if(activeRents.isEmpty) return Center(child: Text("No Data"));

            return ListView.builder(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 16),
              itemCount: activeRents.length,
              itemBuilder: (BuildContext context, int index) {
                return ActiveListingComponent(booking: activeRents[index]);
              },
            );
          }
        },
      ),
    );
  }
}
