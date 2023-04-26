import 'package:flutter/material.dart';
import 'package:renta/fragments/account_fragment.dart';
import 'package:renta/fragments/bookings_fragment.dart';
import 'package:renta/fragments/home_fragment.dart';
import 'package:renta/fragments/listings_fragment.dart';
import 'package:renta/fragments/search_fragment.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? _currentBackPressTime;

  final _pageItem = [
    HomeFragment(),
    BookingsFragment(fromProfile: false),
    SearchFragment(),
    ListingsFragment(fromProfile: false),
    AccountFragment(),
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 30, opacity: 1),
            unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            elevation: 40,
            selectedFontSize: 16,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 20),
                activeIcon: Icon(Icons.home_rounded, size: 20),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined, size: 20),
                activeIcon: Icon(Icons.list_alt, size: 20),
                label: "Rents",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create_outlined, size: 20),
                activeIcon: Icon(Icons.create, size: 20),
                label: "Create",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storage_outlined, size: 20),
                activeIcon: Icon(Icons.storage, size: 20),
                label: "Listings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 20),
                activeIcon: Icon(Icons.person, size: 20),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
