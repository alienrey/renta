import 'package:flutter/material.dart';
import 'package:renta/custom_widget/space.dart';
import 'package:renta/main.dart';
import 'package:renta/models/active_bookings_model.dart';
import 'package:renta/models/renta/Booking.dart';
import 'package:renta/screens/bookings_details_screen.dart';
import 'package:renta/screens/cancel_booking_screen.dart';
import 'package:renta/screens/listing_details_screen.dart';
import 'package:renta/screens/service_screen.dart';
import 'package:renta/utils/colors.dart';
import 'package:renta/utils/images.dart';

class ActiveListingComponent extends StatelessWidget {
  // final ActiveBookingsModel? activeBookingsModel;
  // final int index;
  final Booking? booking;

  ActiveListingComponent({this.booking});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListingDetailsScreen(booking: booking!,)),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rent ID: ${booking!.id}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      booking!.bookingStatus,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: booking!.bookingStatus == "Completed" ? orangeColor : blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Space(4),
                Divider(color: dividerColor, thickness: 1),
                Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.network(booking!.item.photoLink, fit: BoxFit.cover),
                      ),
                    ),
                    Space(8),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(booking!.item.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                          Space(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.watch_later_outlined, color: orangeColor, size: 16),
                              Space(2),
                              Text(booking!.returnDate.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Space(2),
                              // Text("at", style: TextStyle(color: orangeColor, fontSize: 12)),
                              // Space(2),
                              // Text(booking!.returnDate.toIso8601String(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Space(4),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "To Collect: Php ${booking!.extraCharges}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                Space(4),
                Divider(color: dividerColor, thickness: 1),
                Space(4),
                Text(
                  "View",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: blueColor, fontWeight: FontWeight.w900, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
