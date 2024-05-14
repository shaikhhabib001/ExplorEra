import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  String name;
  // String subtext;
  String price;
  String image;

  CustomCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    // required this.subtext,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              widget.image,
              height: 270,
              width: 270,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              // "Bronze",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF000000),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   widget.subtext,
            //   // "2-star hotel with 5 nights stay.\nFree photo session.\nFriendly tour guide.\n24/7 customer help center.\n",
            //   textAlign: TextAlign.center,
            //   style: GoogleFonts.raleway(
            //     color: const Color(0xFF565656),
            //     fontSize: 14,
            //   ),
            // ),
            Text(
              widget.price,
              // "Rs. 9, 999",
              style: GoogleFonts.raleway(
                color: const Color(0xFF29395B),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
