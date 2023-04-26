import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:renta/fragments/bookings_fragment.dart';
import 'package:renta/main.dart';
import 'package:renta/models/customer_details_model.dart';
import 'package:renta/screens/favourite_services_screen.dart';
import 'package:renta/screens/my_profile_screen.dart';
import 'package:renta/screens/notification_screen.dart';
import 'package:renta/screens/sign_in_screen.dart';
import 'package:renta/services/authentication.dart';
import 'package:renta/utils/colors.dart';
import 'package:renta/utils/images.dart';

import '../custom_widget/space.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {

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
          // IconButton(
          //   icon: Icon(Icons.notifications, size: 22),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => NotificationScreen()),
          //     );
          //   },
          // ),
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MyProfileScreen()));
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
                _showLogOutDialog();
              },
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
