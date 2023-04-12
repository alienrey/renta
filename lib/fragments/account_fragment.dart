import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:home_hub/fragments/bookings_fragment.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/models/customer_details_model.dart';
import 'package:home_hub/screens/favourite_services_screen.dart';
import 'package:home_hub/screens/my_profile_screen.dart';
import 'package:home_hub/screens/notification_screen.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:home_hub/utils/images.dart';

import '../custom_widget/space.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: CircleAvatar(
                  backgroundImage: Image.network(
                    "${appData.user?.profilePicture}",
                  ).image)),
            Space(8),
            Text("${appData.user?.firstName} ${appData.user?.lastName}",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            Space(4),
            Text("${appData.user?.email}",
                textAlign: TextAlign.start,
                style: TextStyle(color: secondaryColor, fontSize: 12)),
            Space(16),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.person, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("My Profile"),
              trailing: Icon(Icons.edit, size: 16),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            // ListTile(
            //   horizontalTitleGap: 4,
            //   contentPadding: EdgeInsets.symmetric(horizontal: 16),
            //   leading: Icon(Icons.favorite, size: 20),
            //   title: Text("My Favourites", style: TextStyle()),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => FavouriteProvidersScreen()));
            //   },
            // ),
            // ListTile(
            //   horizontalTitleGap: 4,
            //   contentPadding: EdgeInsets.symmetric(horizontal: 16),
            //   leading: Icon(Icons.notifications, size: 20),
            //   title: Text("Notifications"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => NotificationScreen()));
            //   },
            // ),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.calendar_month, size: 20),
              title: Text("My Rentals"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingsFragment(fromProfile: true)));
              },
            ),
            // ListTile(
            //   horizontalTitleGap: 4,
            //   contentPadding: EdgeInsets.symmetric(horizontal: 16),
            //   leading: Icon(Icons.paid_rounded, size: 20),
            //   title: Text("Refer and earn"),
            //   onTap: () {
            //     //
            //   },
            // ),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.mail, size: 20),
              title: Text("Contact Us"),
              onTap: () {
                //
              },
            ),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.question_mark, size: 20),
              title: Text("Help Center"),
              onTap: () {
                //
              },
            ),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.logout, size: 20),
              title: Text("Log Out"),
              onTap: () {
                //
              },
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
