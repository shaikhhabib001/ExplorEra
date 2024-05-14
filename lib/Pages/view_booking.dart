import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:explore_era/Notifier/flight.notifier.dart';
import 'package:explore_era/Notifier/user.notifier.dart';
import 'package:explore_era/Pages/home.dart';
import 'package:explore_era/Services/email.services.dart';
import 'package:explore_era/modal/flight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewBooking extends StatefulWidget {
  const ViewBooking({super.key});

  @override
  State<ViewBooking> createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBooking> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateCurrentUserFlights();
  }

  updateCurrentUserFlights() {
    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: false);
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    final flights = flightNotifier.flightData
        .where((element) => element.userEmail == userNotifier.user.email)
        .toList();
    flightNotifier.updateCurrentUserFlights(flights);
  }

  @override
  Widget build(BuildContext context) {
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF29395B),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'View Booking',
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: flightNotifier.currentUserFlights.length,
        itemBuilder: (context, index) {
          final Flight flight = Flight(
            flightAirline:
                flightNotifier.currentUserFlights[index].flightAirline,
            flightDepartureDate:
                flightNotifier.currentUserFlights[index].flightDepartureDate,
            flightFrom: flightNotifier.currentUserFlights[index].flightFrom,
            flightPassenger:
                flightNotifier.currentUserFlights[index].flightPassenger,
            flightPrice: flightNotifier.currentUserFlights[index].flightPrice,
            flightReturnDate:
                flightNotifier.currentUserFlights[index].flightReturnDate,
            flightTo: flightNotifier.currentUserFlights[index].flightTo,
            flightclass: flightNotifier.currentUserFlights[index].flightclass,
          );
          return Container(
            height: 80,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 68, 97, 159),
                  Color(0xFF29395B),
                ],
              ),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: flightNotifier
                                    .currentUserFlights[index].flightAirline ==
                                'Emirates'
                            ? Image.asset(
                                'assets/images/emirates.png',
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset(
                                'assets/images/fly_dubai.png',
                                width: 42,
                              ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      flightNotifier.currentUserFlights[index].flightAirline!,
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.yMMMEd().format(
                              DateTime.parse(flightNotifier
                                  .currentUserFlights[index]
                                  .flightDepartureDate!),
                            ),
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            flightNotifier
                                .currentUserFlights[index].flightFrom!,
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            const DottedLine(
                              dashColor: Color.fromARGB(173, 179, 179, 179),
                              lineThickness: 2,
                              dashRadius: 5,
                              dashGapLength: 4,
                              dashLength: 4,
                            ),
                            Transform.rotate(
                              angle: 1.6,
                              child: const Icon(
                                Icons.airplanemode_on,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            flightNotifier
                                .currentUserFlights[index].flightPassenger!,
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            const DottedLine(
                              dashColor: Color.fromARGB(173, 179, 179, 179),
                              lineThickness: 2,
                              dashRadius: 5,
                              dashGapLength: 4,
                              dashLength: 4,
                            ),
                            Transform.rotate(
                              angle: 1.6,
                              child: const Icon(
                                Icons.airplanemode_on,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.yMMMEd().format(
                              DateTime.parse(flightNotifier
                                  .currentUserFlights[index].flightReturnDate!),
                            ),
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            flightNotifier.currentUserFlights[index].flightTo!,
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Text(
                        'Rs: ${flightNotifier.currentUserFlights[index].flightPrice}',
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(
                                'Enter Payment Details',
                                style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF29395B),
                                ),
                              ),
                              content: SizedBox(
                                width: 600,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF29395B),
                                          ),
                                        ),
                                        Text(
                                          userNotifier.user.userName!,
                                          style: GoogleFonts.raleway(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF29395B),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF29395B),
                                              ),
                                            ),
                                            Text(
                                              userNotifier.user.email!,
                                              style: GoogleFonts.raleway(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF29395B),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phone Number',
                                              style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF29395B),
                                              ),
                                            ),
                                            Text(
                                              userNotifier.user.phoneNumber!,
                                              style: GoogleFonts.raleway(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF29395B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    cardNumberController,
                                                decoration: InputDecoration(
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/mastercard.png',
                                                          width: 40,
                                                        ),
                                                        Text(
                                                          '/',
                                                          style: GoogleFonts
                                                              .raleway(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFF29395B),
                                                          ),
                                                        ),
                                                        Image.asset(
                                                          'assets/images/visa.png',
                                                          width: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color.fromARGB(
                                                          150, 102, 102, 102),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color.fromARGB(
                                                          150, 102, 102, 102),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 0,
                                                    horizontal: 20.0,
                                                  ),
                                                  labelText: 'Card Number',
                                                  hintText: 'Enter card number',
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 1,
                                              child: TextField(
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: cvvController,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color.fromARGB(
                                                          150, 102, 102, 102),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color.fromARGB(
                                                          150, 102, 102, 102),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 0,
                                                    horizontal: 20.0,
                                                  ),
                                                  labelText: 'CVV',
                                                  hintText: 'CVV',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (cardNumberController.text.isEmpty &&
                                            cvvController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Enter the card details'),
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                content:
                                                    LinearProgressIndicator(),
                                              );
                                            },
                                          );

                                          Timer(
                                            const Duration(seconds: 2),
                                            () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              EmmailServiecs.sendEmail(
                                                email: userNotifier.user.email!,
                                                message:
                                                    'Your Flight Booking has been confirm and payment has been recieved successfully.\nThe total payment is Rs:${flightNotifier.currentUserFlights[index].flightPrice} Thankyou for choosing us!',
                                                name:
                                                    userNotifier.user.userName!,
                                                subject:
                                                    'Secure Your Seat: Flight Booking Confirmed!',
                                              );

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text(
                                                      'Payment Success!',
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xFF29395B),
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .check_circle_outline_outlined,
                                                          size: 100,
                                                          color: Colors
                                                              .green.shade300,
                                                        ),
                                                        const SizedBox(
                                                            height: 40),
                                                        Text(
                                                          'Your payment has been done',
                                                          style: GoogleFonts
                                                              .raleway(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xFF29395B),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 40),
                                                        GestureDetector(
                                                          onTap: () {
                                                            flightNotifier
                                                                .clearFlightData(
                                                                    flight);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const MyHome(),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          68,
                                                                          97,
                                                                          159),
                                                                  Color(
                                                                      0xFF29395B),
                                                                ],
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Done',
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 60,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromARGB(255, 68, 97, 159),
                                              Color(0xFF29395B),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          'Pay Now',
                                          style: GoogleFonts.raleway(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
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
                          children: [
                            Image.asset(
                              'assets/images/gpay.png',
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Pay Now',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF29395B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        flightNotifier.clearCurrentUserFlights(flight);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.red.shade200,
                              Colors.red.shade500,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Cancel Booking',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
