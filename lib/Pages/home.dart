import 'dart:async';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:explore_era/Components/custom_card.dart';
import 'package:explore_era/Data/countries.dart';
import 'package:explore_era/Notifier/flight.notifier.dart';
import 'package:explore_era/Notifier/notification.notifier.dart';
import 'package:explore_era/Notifier/user.notifier.dart';
import 'package:explore_era/Pages/schedule_flight.dart';
import 'package:explore_era/Pages/view_booking.dart';
import 'package:explore_era/Services/email.services.dart';
import 'package:explore_era/modal/flight.dart';
import 'package:explore_era/Pages/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final DateTime firstDate = DateTime(1990);
  final DateTime lastDate = DateTime(2026);
  bool isVisibleFlights = false;
  bool isVisibleNotifications = false;
  DateTime selectedDepartureDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();
  String? selectedClass;
  String? selectedPassenger;
  String? selectedAirLine;
  bool tripSelected = false;
  bool showNotification = false;
  String? selectedCountryLabel;
  String? departureCountryName;
  String? returnCountryName;
  // List<Flight> currentUserNotifications = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  getNotifications() {
    final NotificationNotifier notificationNotifier =
        Provider.of<NotificationNotifier>(context, listen: false);
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: false);

    Timer.periodic(
      const Duration(minutes: 4),
      (timer) {
        if (flightNotifier.currentUserFlights.isNotEmpty) {
          final randomIndex = flightNotifier.currentUserFlights.length == 1
              ? 0
              : Random().nextInt(flightNotifier.currentUserFlights.length - 1);
          Flight flight = flightNotifier.currentUserFlights[randomIndex];
          final flightPrice = int.parse(flight.flightPrice!.split(',').join());
          final int lowFarePrice = flightPrice - (flightPrice * 0.12).round();
          flight.lowFarePrice = lowFarePrice.toString();
          notificationNotifier.addNotifications(flight);
          final currentUserNotificationsss = notificationNotifier.notifications
              .where((element) => element.userEmail == userNotifier.user.email)
              .toList();
          notificationNotifier
              .updateCurrentUserNotification(currentUserNotificationsss);
          EmmailServiecs.sendEmail(
            email: userNotifier.user.email!,
            message:
                'Dear valued customer,\n\nWe\'re pleased to inform you that the fare for your booked flight from ${flight.flightFrom} to ${flight.flightTo} has been reduced today. We recommend taking advantage of this opportunity by securing your ticket promptly. The revised fare amount is Rs. $lowFarePrice.\n\nThank you for choosing our services. Should you have any questions or require further assistance, feel free to contact us.',
            name: userNotifier.user.userName!,
            subject: 'Exclusive Deal: Grab Your Flight Ticket at a Lower Fare!',
          );
          print('Notification Send');
        } else {
          print('Notification Not Send');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: true);
    final NotificationNotifier notificationNotifier =
        Provider.of<NotificationNotifier>(context, listen: true);

    final currentUserFlights = flightNotifier.flightData
        .where((element) => element.userEmail == userNotifier.user.email)
        .toList();
    final currentUserNotificationsss = notificationNotifier.notifications
        .where((element) => element.userEmail == userNotifier.user.email)
        .toList();
    isVisibleFlights = currentUserFlights.isNotEmpty;
    isVisibleNotifications = currentUserNotificationsss.isNotEmpty;
    // flightNotifier.updateCurrentUserFlights(currentUserFlights);
    // notificationNotifier
    //     .updateCurrentUserNotification(currentUserNotificationsss);

    // // ignore: prefer_is_empty
    // if (currentUserFlights.length == 0) {
    //   setState(() {
    //     isVisibleFlights = false;
    //   });
    // } else {
    //   setState(() {
    //     isVisibleFlights = true;
    //   });
    // }
    // // ignore: prefer_is_empty
    // if (currentUserNotificationsss.length == 0) {
    //   setState(() {
    //     isVisibleNotifications = false;
    //   });
    // } else {
    //   setState(() {
    //     isVisibleNotifications = true;
    //   });
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ? Hero Section
            Stack(
              children: [
                Image.asset(
                  'assets/images/banner.png',
                  fit: BoxFit.cover,
                  height: screenHeight,
                  width: double.infinity,
                ),
                Container(
                  height: screenHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xFF29395B),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ? Heading and Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                  height: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "ExploreEra",
                                  style: GoogleFonts.raleway(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        'assets/images/boy.png',
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      userNotifier.user.userName ?? "",
                                      style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                      tooltip: 'Notifications',
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Notifications',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 20,
                                                  color:
                                                      const Color(0xFF29395B),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              content: SizedBox(
                                                height: 450,
                                                width: 350,
                                                child: ListView.builder(
                                                  itemCount: notificationNotifier
                                                      .currentUserNotification
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 80,
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                68, 97, 159),
                                                            Color(0xFF29395B),
                                                          ],
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: CircleAvatar(
                                                              radius: 28,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: notificationNotifier
                                                                          .currentUserNotification[
                                                                              index]
                                                                          .flightAirline ==
                                                                      'Emirates'
                                                                  ? Image.asset(
                                                                      'assets/images/emirates.png',
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/images/fly_dubai.png',
                                                                      width: 42,
                                                                    ),
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                notificationNotifier
                                                                    .currentUserNotification[
                                                                        index]
                                                                    .flightAirline!,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    notificationNotifier
                                                                        .currentUserNotification[
                                                                            index]
                                                                        .flightFrom!,
                                                                    style: GoogleFonts
                                                                        .raleway(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Transform
                                                                      .rotate(
                                                                    angle: 1.6,
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .airplanemode_on,
                                                                      color: Colors
                                                                          .green,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    notificationNotifier
                                                                        .currentUserNotification[
                                                                            index]
                                                                        .flightTo!,
                                                                    style: GoogleFonts
                                                                        .raleway(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            notificationNotifier
                                                                .currentUserNotification[
                                                                    index]
                                                                .flightPrice!,
                                                            style: GoogleFonts
                                                                .raleway(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 14,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            'Rs: ${notificationNotifier.currentUserNotification[index].lowFarePrice}',
                                                            style: GoogleFonts
                                                                .raleway(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.notifications_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisibleNotifications,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red.shade600,
                                        radius: 8,
                                        child: Center(
                                          child: Text(
                                            notificationNotifier
                                                .currentUserNotification.length
                                                .toString(),
                                            style: GoogleFonts.raleway(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  tooltip: 'Logout',
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const SignIn(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Welcome ${userNotifier.user.userName ?? ""}!',
                                style: GoogleFonts.raleway(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),

                        // ? Filght Scheduling
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    // color: Colors.amber.shade400,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.amber.shade200,
                                        Colors.amber.shade500,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.rotate(
                                        angle: 45,
                                        child: const Icon(
                                          Icons.airplanemode_on,
                                          color: Color(0xFF29395B),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Ticket Booking',
                                        style: GoogleFonts.raleway(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF29395B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Stack(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                      width: 190,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const ViewBooking(),
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.amber.shade200,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.amber.shade200,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'View Booking',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.amber.shade200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisibleFlights,
                                      child: Positioned(
                                        top: 0,
                                        right: 0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red.shade600,
                                          radius: 10,
                                          child: Center(
                                            child: Text(
                                              flightNotifier
                                                  .currentUserFlights.length
                                                  .toString(),
                                              style: GoogleFonts.raleway(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),

                        const SizedBox(height: 50),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: screenWidth * 0.18,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            value: selectedAirLine,
                                            hint: Text(
                                              'Trip',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF29395B)
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: 'Emirates',
                                                child: Text(
                                                  'Emirates',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: 'Fly Dubai',
                                                child: Text(
                                                  'Fly Dubai',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                            ],
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedAirLine = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: double.infinity,
                                          width: screenWidth * 0.18,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            value: selectedPassenger,
                                            hint: Text(
                                              'Passengers',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF29395B)
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: '01',
                                                child: Text(
                                                  '01',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: '02',
                                                child: Text(
                                                  '02',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: '03',
                                                child: Text(
                                                  '03',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: '04',
                                                child: Text(
                                                  '04',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: '05',
                                                child: Text(
                                                  '05',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                            ],
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedPassenger = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: double.infinity,
                                          width: screenWidth * 0.18,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButton<String>(
                                            hint: Text(
                                              'Select Class',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF29395B)
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            value: selectedClass,
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: 'Business Class',
                                                child: Text(
                                                  'Business Class',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: 'Economy Class',
                                                child: Text(
                                                  'Economy Class',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                              ),
                                            ],
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedClass = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  height: 190,
                                  width: screenWidth * 0.55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Trip Details:',
                                            style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: tripSelected
                                                  ? const Color(0xFF29395B)
                                                  : const Color(0xFF29395B)
                                                      .withOpacity(0.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey.shade300
                                                    .withOpacity(0.4),
                                                border: Border.all(
                                                  color:
                                                      Colors.blueGrey.shade300,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      "From",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFF29395B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        // ignore: use_build_context_synchronously
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  'Select Country:',
                                                                  style: GoogleFonts
                                                                      .raleway(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: const Color(
                                                                        0xFF29395B),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 400,
                                                                  width: 200,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount: Countries
                                                                        .countries
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      final country =
                                                                          Countries
                                                                              .countries[index];
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            departureCountryName =
                                                                                country['code'];
                                                                          });

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          title:
                                                                              Text(
                                                                            country['name'],
                                                                            style:
                                                                                GoogleFonts.raleway(
                                                                              fontSize: 18,
                                                                              color: const Color(0xFF29395B),
                                                                            ),
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
                                                      );
                                                    },
                                                    child: Text(
                                                      departureCountryName ??
                                                          "AF",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                          0xFF29395B,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  const DottedLine(
                                                    dashColor: Color.fromARGB(
                                                        173, 179, 179, 179),
                                                    lineThickness: 2,
                                                    dashRadius: 5,
                                                    dashGapLength: 4,
                                                    dashLength: 4,
                                                  ),
                                                  Transform.rotate(
                                                    angle: 1.6,
                                                    child: Icon(
                                                      Icons.airplanemode_on,
                                                      color: const Color(
                                                              0xFF29395B)
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '2 hrs 22 min',
                                                  style: GoogleFonts.raleway(),
                                                ),
                                                Icon(
                                                  Icons.timelapse_rounded,
                                                  color: const Color(0xFF29395B)
                                                      .withOpacity(0.4),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Stack(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  const DottedLine(
                                                    dashColor: Color.fromARGB(
                                                        173, 179, 179, 179),
                                                    lineThickness: 2,
                                                    dashRadius: 5,
                                                    dashGapLength: 4,
                                                    dashLength: 4,
                                                  ),
                                                  Transform.rotate(
                                                    angle: 1.6,
                                                    child: Icon(
                                                      Icons.airplanemode_on,
                                                      color: const Color(
                                                              0xFF29395B)
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey.shade300
                                                    .withOpacity(0.4),
                                                border: Border.all(
                                                  color:
                                                      Colors.blueGrey.shade300,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      "TO",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFF29395B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        // ignore: use_build_context_synchronously
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  'Select Country:',
                                                                  style: GoogleFonts
                                                                      .raleway(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: const Color(
                                                                        0xFF29395B),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 400,
                                                                  width: 200,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount: Countries
                                                                        .countries
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      final country =
                                                                          Countries
                                                                              .countries[index];
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            returnCountryName =
                                                                                country['code'];
                                                                          });

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          title:
                                                                              Text(
                                                                            country['name'],
                                                                            style:
                                                                                GoogleFonts.raleway(
                                                                              fontSize: 18,
                                                                              color: const Color(0xFF29395B),
                                                                            ),
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
                                                      );
                                                    },
                                                    child: Text(
                                                      returnCountryName ?? "PK",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xFF29395B),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: 260,
                              height: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DEPARTURE',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF29395B),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat.yMMMEd()
                                            .format(selectedDepartureDate),
                                        style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF29395B),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            firstDate: firstDate,
                                            lastDate: lastDate,
                                            currentDate: DateTime.now(),
                                          ).then((value) {
                                            setState(() {
                                              selectedDepartureDate =
                                                  value ?? DateTime.now();
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: const Color(0xFF29395B)
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  Text(
                                    'RETURN',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF29395B),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat.yMMMEd()
                                            .format(selectedReturnDate),
                                        style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF29395B),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            firstDate: firstDate,
                                            lastDate: lastDate,
                                            currentDate: DateTime.now(),
                                          ).then((value) {
                                            setState(() {
                                              selectedReturnDate =
                                                  value ?? DateTime.now();
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: const Color(0xFF29395B)
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (selectedAirLine != null &&
                                    selectedPassenger != null &&
                                    selectedClass != null) {
                                  flightNotifier.addFlightPassenger(
                                      selectedPassenger ?? "00");
                                  flightNotifier.addAirLine(
                                      selectedAirLine ?? "Emirates");
                                  flightNotifier.addFlightClass(
                                      selectedClass ?? "Businesss Class");
                                  flightNotifier.addFlightFrom(
                                      departureCountryName ?? "PK");
                                  flightNotifier
                                      .addFlightTo(returnCountryName ?? "US");
                                  flightNotifier.addFlightDepartureDate(
                                      selectedDepartureDate.toIso8601String());
                                  flightNotifier.addFlightReturnDate(
                                      selectedReturnDate.toIso8601String());

                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const ScheduleFlight(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Fill details'),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 250,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.amber.shade200,
                                      Colors.amber.shade500,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xFF29395B),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Book Flight',
                                      style: GoogleFonts.raleway(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF29395B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: showNotification,
                  child: Positioned(
                    top: 90,
                    right: 130,
                    child: Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

            // ? Packages Section
            Container(
              height: screenHeight,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 70),
              color: const Color(0xFF29395B),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Packages',
                    style: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        image: 'assets/images/bali.jpg',
                        name: "Bali",
                        price: "Rs. 32,800",
                      ),
                      CustomCard(
                        image: 'assets/images/genevaa.png',
                        name: "Geneva",
                        price: "Rs. 45,700",
                      ),
                      CustomCard(
                        image: 'assets/images/dubai.jpg',
                        name: "Dubai",
                        price: "Rs. 27,500",
                      ),
                      CustomCard(
                        image: 'assets/images/london.png',
                        name: "London",
                        price: "Rs. 33,100",
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
  }
}

Widget buildMaterial(
  BuildContext context,
  String name,
  String subtext,
  String price,
  String image,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      color: color,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.black26,
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: AssetImage(image),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtext,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                color: Color(0xFF565656),
                fontFamily: 'Comfortaa',
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFF29395B),
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ),
  );
}
