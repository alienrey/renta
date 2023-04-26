import 'package:flutter/material.dart';
import 'package:renta/components/service_list_component.dart';
import 'package:renta/models/renta/Rentals.dart';
import 'package:renta/screens/provider_services_screen.dart';
import 'package:renta/utils/widgets.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/renovate_services_model.dart';
import '../models/services_model.dart';
import '../utils/colors.dart';
import 'all_categories_screen.dart';

class ProviderDetailScreen extends StatefulWidget {
  final int serviceIndex;
  final int index;
  final String itemId;

  const ProviderDetailScreen(
      {Key? key,
      required this.serviceIndex,
      required this.index,
      required this.itemId})
      : super(key: key);

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  double titleFontSize = 16;
  double subtitleFontSize = 19;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: transparent,
            title: Text(
              "Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          bottomSheet: BottomSheet(
            elevation: 10,
            enableDrag: false,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: appData.isDark ? whiteColor : blackColor,
                            fixedSize: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.06),
                            shape: StadiumBorder(),
                            side: BorderSide(
                                color: appData.isDark ? whiteColor : blackColor,
                                width: 1)),
                        child: Icon(Icons.message_rounded, size: 20),
                        onPressed: () {
                          //
                        },
                      ),
                    ),
                    Space(16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * 0.06),
                          shape: StadiumBorder(),
                        ),
                        child: Text("Book"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderServicesScreen(
                                  serviceIndex: widget.serviceIndex,
                                  index: widget.index,
                                  itemId: widget.itemId,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          ),
          body: FutureBuilder<Rental>(
            future: FirebaseRentalService().getRental(widget.itemId),
            builder: (BuildContext contex, AsyncSnapshot<Rental> snapshot) {
              if (snapshot.hasData) {
                // Build the list using the data returned from the future
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      blackColor,
                                      transparent,
                                      transparent,
                                      transparent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0, 0.2, 0.8, 1],
                                  ),
                                ),
                                child: Image.network(
                                  snapshot.data!.photoLink,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   left: 0,
                            //   right: 0,
                            //   bottom: 8,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(bottom: 8.0),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Column(
                            //           children: [
                            //             Text("jobs",
                            //                 style: TextStyle(
                            //                     color: whiteColor,
                            //                     fontSize: 12)),
                            //             Space(4),
                            //             Text(
                            //               serviceProviders[widget.serviceIndex]
                            //                   .serviceProviders[widget.index]
                            //                   .jobs,
                            //               style: TextStyle(
                            //                   color: whiteColor,
                            //                   fontWeight: FontWeight.w900,
                            //                   fontSize: 18),
                            //             ),
                            //           ],
                            //         ),
                            //         Column(
                            //           children: [
                            //             Text("share",
                            //                 style: TextStyle(
                            //                     color: whiteColor,
                            //                     fontSize: 12)),
                            //             Space(4),
                            //             Icon(
                            //               Icons.share,
                            //               color: whiteColor,
                            //               size: 18,
                            //             ),
                            //           ],
                            //         ),
                            //         Column(
                            //           children: [
                            //             Text("Rating",
                            //                 style: TextStyle(
                            //                     color: whiteColor,
                            //                     fontSize: 12)),
                            //             Space(4),
                            //             Text(
                            //               serviceProviders[widget.serviceIndex]
                            //                   .serviceProviders[widget.index]
                            //                   .star,
                            //               style: TextStyle(
                            //                   color: whiteColor,
                            //                   fontWeight: FontWeight.w900,
                            //                   fontSize: 18),
                            //             ),
                            //           ],
                            //         ),
                            //         Column(
                            //           children: [
                            //             Text("Save",
                            //                 style: TextStyle(
                            //                     color: whiteColor,
                            //                     fontSize: 12)),
                            //             Space(4),
                            //             GestureDetector(
                            //               onTap: () {
                            //                 setLiked(widget.serviceIndex,
                            //                     widget.index);
                            //                 setState(() {});
                            //               },
                            //               child: serviceProviders[
                            //                           widget.serviceIndex]
                            //                       .serviceProviders[
                            //                           widget.index]
                            //                       .isLiked
                            //                   ? Icon(Icons.favorite,
                            //                       color: Colors.red, size: 18)
                            //                   : Icon(
                            //                       Icons.favorite,
                            //                       color: Colors.white,
                            //                       size: 18,
                            //                     ),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        child: Card(
                          color: appData.isDark ? cardColorDark : cardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Item Name",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: titleFontSize),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          snapshot.data!.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: subTitle,
                                              fontSize: subtitleFontSize),
                                        ),
                                      ),
                                      Space(8),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Item Description",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: titleFontSize),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          snapshot.data!.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: subTitle,
                                              fontSize: subtitleFontSize),
                                        ),
                                      ),
                                      Space(8),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Rate (Per Day)",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: titleFontSize),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          "Php ${snapshot.data!.pricePerDay.toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: subTitle,
                                              fontSize: subtitleFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // homeTitleWidget(
                      //   titleText: "Recent Projects",
                      //   onAllTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => AllCategoriesScreen(
                      //           list: renovateServices,
                      //           fromProviderDetails: true,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      Space(70),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // Handle error state
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // Show loading indicator while waiting for data to load
                return Center(
                  child: Text('Please wait. Loading data.'),
                );
              }
            },
          ),
        ));
  }
}
