import 'package:flutter/material.dart';
import 'package:renta/screens/ActiveListings.dart';
import 'package:renta/screens/ListingsHistory.dart';
import 'package:renta/screens/active_bookings_screen.dart';
import 'package:renta/screens/booking_history_screen.dart';
import 'package:renta/utils/colors.dart';

class ListingsFragment extends StatefulWidget {
  final bool fromProfile;

  const ListingsFragment({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<ListingsFragment> createState() => _ListingsFragmentState();
}

class _ListingsFragmentState extends State<ListingsFragment> with SingleTickerProviderStateMixin {
  late TabController bookingTabController = TabController(length: 2, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "My Listings",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        bottom: TabBar(
          controller: bookingTabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          indicatorColor: blackColor,
          tabs: [
            Tab(text: "Active Listings"),
            Tab(text: "Listings History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: bookingTabController,
        children: [
          ActiveListings(),
          ListingsHistory(),
        ],
      ),
      // body: Center(child: Text("Under Construction..."),)
    );
  }
}
