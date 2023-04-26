import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:renta/components/apartment_size_component.dart';
import 'package:renta/main.dart';
import 'package:renta/models/active_bookings_model.dart';
import 'package:renta/models/combos_services_model.dart';
import 'package:renta/models/renovate_services_model.dart';
import 'package:renta/models/renta/Booking.dart';
import 'package:renta/models/renta/Rentals.dart';
import 'package:renta/models/renta/User.dart';
import 'package:renta/screens/dashboard_screen.dart';
import 'package:renta/services/BookingService.dart';
import 'package:renta/services/authentication.dart';
import 'package:renta/services/userdataService.dart';
import 'package:renta/utils/constant.dart';
import 'package:renta/utils/date.dart' as date;
import 'package:renta/utils/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_widget/space.dart';
import '../models/services_model.dart';
import '../utils/colors.dart';
import 'order_summery_screen.dart';

class BookingsDetailScreen extends StatefulWidget {
  final int index;
  final bool fromRenovate;
  final bool fromBooking;
  final int serviceIndex;
  final int providerIndex;
  final Booking booking;

  const BookingsDetailScreen(
      {Key? key,
      this.index = 0,
      this.fromRenovate = false,
      this.fromBooking = false,
      this.serviceIndex = 0,
      this.providerIndex = 0,
      required this.booking})
      : super(key: key);

  @override
  State<BookingsDetailScreen> createState() => _BookingsDetailScreenState();
}

class _BookingsDetailScreenState extends State<BookingsDetailScreen> {
  List<DateTime> currentMonthList = [];

  DateTime currentDateTime = DateTime.now();

  int monthIndex = 0;

  String selectedMonth = "";
  String selectedMonthShort = "";
  String selectedYear = "";

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  List<ActiveBookingsModel> temporaryList = [];

  String selectedArea = "";
  String selectedBHK = "";
  String selectedDate = "";
  String selectedWeekday = "";

  Color _textColor = transparent;
  Color _iconColor = whiteColor;

  late ScrollController _scrollController;

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200);
  }

  @override
  void initState() {
    init();
    selectedMonth = date.DateUtils.months[currentDateTime.month - 1];
    selectedMonthShort = date.DateUtils.monthShort[currentDateTime.month - 1];
    selectedYear = currentDateTime.year.toString();
    selectedDate =
        "${currentDateTime.day.toString()} $selectedMonthShort,$selectedYear";
    monthIndex = currentDateTime.month - 1;
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded
              ? appData.isDark
                  ? whiteColor
                  : blackColor
              : transparent;
          _iconColor = _isSliverAppBarExpanded
              ? appData.isDark
                  ? whiteColor
                  : blackColor
              : whiteColor;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void init() {
    currentMonthList = date.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
  }

  void _selectTime() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (_, child) {
        return Theme(
          data: appData.isDark ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      _time = newTime;
      setState(() {});
    }
  }

  Widget? getButton(String status) {
    if (status == pending) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.06),
          shape: StadiumBorder(),
        ),
        child: Text("Confirm"),
        onPressed: () {
          context.loaderOverlay.show();
          final updatedBooking = widget.booking;
          updatedBooking.bookingStatus = renting;
          updatedBooking.item.isRented = true;
          FirebaseBookingService().updateBooking(updatedBooking).then((value) => {
            context.loaderOverlay.hide(),
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message:
                    'Operation Successful!',
              ),
            ),
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen(defaultPageIndex: 3,)),
              (route) => false,
            ),
          }).onError((error, stackTrace) => {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message:
                    'Operation Failed!',
              ),
            ),
          });
        },
      );
    }

    if (status == renting) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.06),
          shape: StadiumBorder(),
        ),
        child: Text("Complete"),
        onPressed: () {
          context.loaderOverlay.show();
          final updatedBooking = widget.booking;
          updatedBooking.bookingStatus = completed;
          updatedBooking.item.isRented = false;
          FirebaseBookingService().updateBooking(updatedBooking).then((value) => {
            context.loaderOverlay.hide(),
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message:
                    'Operation Successful!',
              ),
            ),
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen(defaultPageIndex: 3,)),
              (route) => false,
            ),
          }).onError((error, stackTrace) => {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message:
                    'Operation Failed!',
              ),
            ),
          });
        },
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.06),
        shape: StadiumBorder(),
      ),
      child: Text("Disabled"),
      onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashBoardScreen(defaultPageIndex: 3,)),
            (route) => false,
          );
        // context.loaderOverlay.show();
      },
    );
  }

  double titleFontSize = 18;
  double subtitleFontSize = 20;
  String phone = "";
  Rental? rentalItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () async {
                        final String phoneNumber =
                            'sms:$phone'; // replace with your own phone number
                        if (await canLaunch(phoneNumber)) {
                          await launch(phoneNumber);
                        } else {
                          throw 'Could not launch $phoneNumber';
                        }
                      }),
                ),
                Space(16),
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
                      child: Icon(Icons.phone_rounded, size: 20),
                      onPressed: () async {
                        final String phoneNumber =
                            'tel:$phone'; // replace with your own phone number
                        if (await canLaunch(phoneNumber)) {
                          await launch(phoneNumber);
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: 'Failed to open dialer!',
                            ),
                          );
                        }
                      }),
                ),
                Space(16),
                // Expanded(child: getButton(widget.booking.bookingStatus)!),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
      // bottomSheet: BottomSheet(
      //   elevation: 10,
      //   enableDrag: false,
      //   builder: (context) {
      //     return Padding(
      //       padding: EdgeInsets.all(10),
      //       child: Container(
      //         padding: EdgeInsets.symmetric(horizontal: 20),
      //         height: MediaQuery.of(context).size.height * 0.06,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: BoxDecoration(
      //           color: appData.isDark ? bottomContainerDark : bottomContainerBorder,
      //           borderRadius: BorderRadius.circular(40),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "\$ ${serviceProviders[widget.serviceIndex].serviceProviders[widget.providerIndex].providerServices[widget.index].servicePrice}",
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 color: appData.isDark ? bottomContainerTextDark : bottomContainerText,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             TextButton(
      //               onPressed: () {
      //                 temporaryList.add(
      //                   ActiveBookingsModel(
      //                     0,
      //                     serviceProviders[widget.serviceIndex].serviceProviders[widget.providerIndex].providerServices[widget.index].serviceName,
      //                     serviceProviders[widget.serviceIndex].serviceProviders[widget.providerIndex].providerServices[widget.index].serviceImage,
      //                     "John Cleaning Services",
      //                     selectedDate,
      //                     _time.format(context),
      //                     "In Process",
      //                     serviceProviders[widget.serviceIndex].serviceProviders[widget.providerIndex].providerServices[widget.index].servicePrice,
      //                   ),
      //                 );
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => OrderSummeryScreen(
      //                       list: temporaryList,
      //                       area: selectedArea,
      //                       bHK: selectedBHK,
      //                       weekday: selectedWeekday,
      //                       fromBooking: widget.fromBooking,
      //                       renovateIndex: widget.index,
      //                       fromRenovate: widget.fromRenovate,
      //                     ),
      //                   ),
      //                 );
      //               },
      //               child: Text(
      //                 "Continue",
      //                 style: TextStyle(
      //                   color: appData.isDark ? bottomContainerTextDark : bottomContainerText,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 16,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      //   onClosing: () {},
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            titleTextStyle: TextStyle(
                color: _textColor, fontWeight: FontWeight.w900, fontSize: 20),
            backgroundColor: customAppbarColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: _iconColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.booking.item.photoLink,
                fit: BoxFit.cover,
              ),
            ),
            centerTitle: true,
            title: Text(
              widget.fromBooking
                  ? serviceProviders[widget.serviceIndex]
                      .serviceProviders[widget.providerIndex]
                      .providerServices[widget.index]
                      .serviceName
                  : widget.fromRenovate
                      ? renovateServices[widget.index].title
                      : combosServices[widget.index].title,
              textAlign: TextAlign.center,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Item Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize)),
                  Space(8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.booking.item.name,
                          style: TextStyle(fontSize: subtitleFontSize)),
                    ),
                  ),
                  Space(16),
                  Text("Item Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize)),
                  Space(8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.booking.item.description,
                          style: TextStyle(fontSize: subtitleFontSize)),
                    ),
                  ),
                  Space(16),
                  Text("Rate (Per Day)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize)),
                  Space(8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Php ${widget.booking.item.pricePerDay.toString()}",
                          style: TextStyle(fontSize: subtitleFontSize)),
                    ),
                  ),
                  Space(16),
                  FutureBuilder<UserData>(
                      future: FirebaseUserService()
                          .getUserData(widget.booking.renterId),
                      builder: (BuildContext contex,
                          AsyncSnapshot<UserData> snapshot) {
                        if (snapshot.hasData) {
                          phone = snapshot.data!.phoneNumber;
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Owner Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: titleFontSize)),
                                Space(8),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${snapshot.data?.firstName} ${snapshot.data?.lastName}",
                                        style: TextStyle(
                                            fontSize: subtitleFontSize)),
                                  ),
                                ),
                                Space(16),
                                Text("Phone Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: titleFontSize)),
                                Space(8),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data!.phoneNumber,
                                        style: TextStyle(
                                            fontSize: subtitleFontSize)),
                                  ),
                                ),
                                Space(60),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return Center(
                              child: Text("Please wait. Loading data."));
                        }
                      }),
                  Space(16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
