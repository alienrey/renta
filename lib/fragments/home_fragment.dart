import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:renta/components/combos_subscriptions_component.dart';
import 'package:renta/components/customer_review_component.dart';
import 'package:renta/components/home_contruction_component.dart';
import 'package:renta/components/home_service_component.dart';
import 'package:renta/components/popular_service_component.dart';
import 'package:renta/components/renovate_home_component.dart';
import 'package:renta/components/search_component.dart';
import 'package:renta/fragments/bookings_fragment.dart';
import 'package:renta/models/customer_details_model.dart';
import 'package:renta/models/renta/Rentals.dart';
import 'package:renta/screens/notification_screen.dart';
import 'package:renta/screens/provider_detail_screen.dart';
import 'package:renta/screens/provider_services_screen.dart';
import 'package:renta/screens/service_providers_screen.dart';
import 'package:renta/screens/service_screen.dart';
import 'package:renta/screens/sign_in_screen.dart';
import 'package:renta/services/authentication.dart';
import 'package:renta/utils/images.dart';
import 'package:renta/utils/widgets.dart';
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
  final index = 0;
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
  List<String> bannerList = [banner1, banner2, banner];

  final offerPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  Future<void> _navigateToProviderDetailScreen(int index, String itemId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServiceScreen(itemId: itemId),
      ),
    );
    if (result) {
      setState(() {});
    }
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
        title: Text(
          "Home",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
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
          // Observer(
          //   builder: (context) {
          //     return Padding(
          //       padding: EdgeInsets.all(10.0),
          //       child: Switch(
          //         value: appData.isDark,
          //         onChanged: (value) {
          //           setState(() {
          //             appData.toggle();
          //           });
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "${appData.user!.firstName[0]}",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: appData.isDark ? Colors.black : whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appData.isDark ? whiteColor : Colors.black,
                    ),
                  ),
                  Space(4),
                  Text(
                    "${appData.user!.firstName} ${appData.user!.lastName}",
                    style: TextStyle(
                        fontSize: 18,
                        color: appData.isDark ? whiteColor : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(appData.user!.email,
                      style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                // Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            // drawerWidget(
            //   drawerTitle: "My Favourites",
            //   drawerIcon: Icons.favorite,
            //   drawerOnTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteProvidersScreen()));
            //   },
            // ),
            // drawerWidget(
            //   drawerTitle: "Notifications",
            //   drawerIcon: Icons.notifications,
            //   drawerOnTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            //   },
            // ),
            // drawerWidget(
            //   drawerTitle: "My bookings",
            //   drawerIcon: Icons.calendar_month,
            //   drawerOnTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => BookingsFragment(fromProfile: true)),
            //     );
            //   },
            // ),
            // drawerWidget(
            //   drawerTitle: "Refer and earn",
            //   drawerIcon: Icons.paid_rounded,
            //   drawerOnTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // drawerWidget(
            //   drawerTitle: "Contact Us",
            //   drawerIcon: Icons.mail,
            //   drawerOnTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // drawerWidget(
            //   drawerTitle: "Help Center",
            //   drawerIcon: Icons.question_mark_rounded,
            //   drawerOnTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
          Expanded(
            child: FutureBuilder<List<Rental>>(
              future: FirebaseRentalService().getAllRentals(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Rental>> snapshot) {
                if (snapshot.hasData) {

                  final filteredList = snapshot.data?.where((element) => element.ownerId != FirebaseAuthService.getCurrentUserId()).toList();
                  
                  if(filteredList!.isEmpty){
                    return Center(
                      child: Text('No items are listed yet.'),
                    );
                  }
                  // Build the list using the data returned from the future
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.all(8),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _navigateToProviderDetailScreen(index, filteredList[index].id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appData.isDark
                                ? Colors.black
                                : Colors.grey.withOpacity(0.2),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      filteredList[index].photoLink,
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 0,
                                  //   left: 0,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(6.0),
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         setLiked(widget.index, index);
                                  //         setState(() {});
                                  //       },
                                  //       child: CircleAvatar(
                                  //         maxRadius: 18,
                                  //         backgroundColor: likedIconBackColor,
                                  //         child: SizedBox(
                                  //           height: 16,
                                  //           width: 16,
                                  //           child: serviceProviders[widget.index]
                                  //                   .serviceProviders[index]
                                  //                   .isLiked
                                  //               ? Icon(
                                  //                   Icons.favorite,
                                  //                   size: 18,
                                  //                   color: Colors.red,
                                  //                 )
                                  //               : Image.asset(icHeart,
                                  //                   color: Colors.black),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              Space(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredList[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        Space(4),
                                        Text(
                                          filteredList[index].description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: greyColor, fontSize: 14),
                                        ),
                                        Space(4),
                                        // Row(
                                        //   children: [
                                        //     Icon(Icons.star,
                                        //         color: starIconColor, size: 16),
                                        //     Text(
                                        //       serviceProviders[widget.index]
                                        //           .serviceProviders[index]
                                        //           .star,
                                        //       style: TextStyle(
                                        //           fontWeight: FontWeight.bold,
                                        //           fontSize: 16),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    Space(16),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Php ${filteredList[index].pricePerDay}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      "/day ",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Space(8),
                                                ElevatedButton(
                                                  child: Text("Book",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  onPressed: () {
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         ProviderServicesScreen(
                                                    //             serviceIndex:
                                                    //                 widget.index,
                                                    //             index: index),
                                                    //   ),
                                                    // );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    backgroundColor: appData
                                                            .isDark
                                                        ? Colors.grey
                                                            .withOpacity(0.2)
                                                        : Colors.black,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16,
                                                            horizontal: 32),
                                                    fixedSize: Size(140, 50),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // Show loading indicator while waiting for data to load
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
