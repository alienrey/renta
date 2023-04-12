import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:home_hub/components/combos_subscriptions_component.dart';
import 'package:home_hub/components/customer_review_component.dart';
import 'package:home_hub/components/home_contruction_component.dart';
import 'package:home_hub/components/home_service_component.dart';
import 'package:home_hub/components/popular_service_component.dart';
import 'package:home_hub/components/renovate_home_component.dart';
import 'package:home_hub/components/search_component.dart';
import 'package:home_hub/fragments/bookings_fragment.dart';
import 'package:home_hub/models/customer_details_model.dart';
import 'package:home_hub/screens/notification_screen.dart';
import 'package:home_hub/screens/service_providers_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/services/authentication.dart';
import 'package:home_hub/utils/images.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../models/services_model.dart';
import '../screens/all_categories_screen.dart';
import '../screens/favourite_services_screen.dart';
import '../screens/my_profile_screen.dart';
import '../utils/colors.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
  List<String> bannerList = [banner1, banner2, banner];

  final offerPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await FirebaseAuthService.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          Observer(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Switch(
                  value: appData.isDark,
                  onChanged: (value) {
                    setState(() {
                      appData.toggle();
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "J",
                      style: TextStyle(fontSize: 24.0, color: appData.isDark ? Colors.black : whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appData.isDark ? whiteColor : Colors.black,
                    ),
                  ),
                  Space(4),
                  Text(
                    getName,
                    style: TextStyle(fontSize: 18, color: appData.isDark ? whiteColor : Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(getEmail, style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My Favourites",
              drawerIcon: Icons.favorite,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteProvidersScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Notifications",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My bookings",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsFragment(fromProfile: true)),
                );
              },
            ),
            drawerWidget(
              drawerTitle: "Refer and earn",
              drawerIcon: Icons.paid_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Contact Us",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Help Center",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Logout",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                _showLogOutDialog();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 17),
                  decoration: commonInputDecoration(
                    hintText: "Search for services",
                    suffixIcon: Icon(Icons.search, size: 18),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              itemCount: serviceProviders.length,
              itemBuilder: (context, index) {
                return SearchComponent(index, servicesModel: serviceProviders[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
