import 'package:flutter/material.dart';
import 'package:renta/components/active_booking_component.dart';
import 'package:renta/components/active_listing_component.dart';
import 'package:renta/models/renta/Booking.dart';
import 'package:renta/services/BookingService.dart';
import 'package:renta/utils/constant.dart';

class ListingsHistory extends StatefulWidget {
  const ListingsHistory({Key? key}) : super(key: key);

  @override
  State<ListingsHistory> createState() => _ListingsHistoryState();
}

class _ListingsHistoryState extends State<ListingsHistory> {
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

            final completedRents = snapshot.data!.where((element) => element.bookingStatus == completed).toList();
            
            if(completedRents.isEmpty) return Center(child: Text("No Data"));


            return ListView.builder(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 16),
              itemCount: completedRents.length,
              itemBuilder: (BuildContext context, int index) {
                return ActiveListingComponent(booking: completedRents[index]);
              },
            );
          }
        },
      ),
    );
  }
}
