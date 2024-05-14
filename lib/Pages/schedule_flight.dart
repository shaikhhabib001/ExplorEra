import 'dart:async';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:explore_era/Notifier/flight.notifier.dart';
import 'package:explore_era/Notifier/user.notifier.dart';
import 'package:explore_era/Services/stringFormat.service.dart';
import 'package:explore_era/modal/flight.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleFlight extends StatefulWidget {
  const ScheduleFlight({super.key});

  @override
  State<ScheduleFlight> createState() => _ScheduleFlightState();
}

class _ScheduleFlightState extends State<ScheduleFlight> {
  DateTime flightDepartureDate = DateTime.now();
  DateTime flightReturnDate = DateTime.now();
  String flightFrom = '';
  String flightTo = '';
  String flightPassenger = '';
  String selectedAirLine = '';
  String flightClass = '';

  final priceList = [
    '30200',
    '32700',
    '27500',
    '45200',
    '28300',
    '36800',
    '77600',
    '89100',
    '55400'
  ];

  @override
  void initState() {
    super.initState();
    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: false);
    DateTime formattedDepartureDate =
        DateTime.parse(flightNotifier.flightDepartureDate);
    DateTime formattedReturnDate =
        DateTime.parse(flightNotifier.flightReturnDate);

    flightDepartureDate = formattedDepartureDate;
    flightReturnDate = formattedReturnDate;
    flightFrom = flightNotifier.flightFrom;
    flightTo = flightNotifier.flightTo;
    flightPassenger = flightNotifier.flightPassenger;
    flightClass = flightNotifier.flightClass;
    selectedAirLine = flightNotifier.selectedAirLine;
  }

  final priceIndex = Random().nextInt(8);
  @override
  Widget build(BuildContext context) {
    String price = priceList[priceIndex];
    int priceInt = int.parse(price);
    int passengerInt = int.parse(flightPassenger);
    int finalPrice = priceInt * passengerInt;
    final String stringFinalPrice = finalPrice.toString();
    String formattedPrice = StringService.addComma(stringFinalPrice);
    final FlightNotifier flightNotifier =
        Provider.of<FlightNotifier>(context, listen: false);
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
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
          'Schedule Flight',
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
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
                          child: flightNotifier.selectedAirLine == 'Emirates'
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
                        selectedAirLine,
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 100),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.yMMMEd().format(flightDepartureDate),
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              flightNotifier.flightFrom,
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                        Icon(
                          Icons.timelapse_rounded,
                          color: Colors.white.withOpacity(0.4),
                        ),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.yMMMEd().format(flightReturnDate),
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              flightNotifier.flightTo,
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 80),
                ],
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white,
                                  child: flightNotifier.selectedAirLine ==
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
                                const SizedBox(width: 15),
                                Text(
                                  selectedAirLine,
                                  style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(flightDepartureDate),
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(flightReturnDate),
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      flightNotifier.flightClass,
                                      style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 80),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outline_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        Text(
                                          flightNotifier.flightPassenger,
                                          style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 6,
                                        ),
                                        SizedBox(
                                          height: 100,
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            dashColor: Color.fromARGB(
                                                173, 179, 179, 179),
                                            lineThickness: 2,
                                            dashRadius: 5,
                                            dashGapLength: 4,
                                            dashLength: 4,
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 6,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'From',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    flightFrom,
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 150,
                                              child: DottedLine(
                                                dashColor: Color.fromARGB(
                                                    173, 179, 179, 179),
                                                lineThickness: 3,
                                                dashRadius: 5,
                                                dashGapLength: 5,
                                                dashLength: 7,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'To',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    flightTo,
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 50),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'From',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    flightTo,
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 150,
                                              child: DottedLine(
                                                dashColor: Color.fromARGB(
                                                    173, 179, 179, 179),
                                                lineThickness: 3,
                                                dashRadius: 5,
                                                dashGapLength: 5,
                                                dashLength: 7,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'To',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    flightFrom,
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Price',
                                  style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 180.65,
                                  child: Text(
                                    'Rs $formattedPrice',
                                    style: GoogleFonts.raleway(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: double.infinity,
                        child: DottedLine(
                          direction: Axis.vertical,
                          dashColor: Colors.white,
                          lineThickness: 4,
                          dashRadius: 8,
                          dashGapLength: 6,
                          dashLength: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.asset(
                            'assets/images/qr_code.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 80,
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Totol Price:',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Rs: $formattedPrice',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: LinearProgressIndicator(),
                            );
                          },
                        );

                        final Flight flight = Flight(
                          flightAirline: selectedAirLine,
                          flightDepartureDate:
                              flightDepartureDate.toIso8601String(),
                          flightFrom: flightFrom,
                          flightPassenger: flightPassenger,
                          flightPrice: formattedPrice,
                          flightReturnDate: flightReturnDate.toIso8601String(),
                          flightTo: flightTo,
                          flightclass: flightClass,
                          userEmail: userNotifier.user.email,
                        );
                        
                        flightNotifier.addFlightData(flight);

                        Timer(
                          const Duration(seconds: 2),
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
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
                            const Icon(
                              Icons.event_available,
                              color: Color(0xFF29395B),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Confirm Booking',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF29395B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
