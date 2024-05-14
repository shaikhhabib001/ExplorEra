import 'dart:convert';

Flight flightFromJson(String str) => Flight.fromJson(json.decode(str));

String flightToJson(Flight data) => json.encode(data.toJson());

class Flight {
  String? flightAirline;
  String? flightPassenger;
  String? flightclass;
  String? flightFrom;
  String? flightTo;
  String? flightDepartureDate;
  String? flightReturnDate;
  String? flightPrice;
  String? lowFarePrice;
  String? userEmail;

  Flight({
    this.flightAirline,
    this.flightDepartureDate,
    this.flightFrom,
    this.flightTo,
    this.flightPassenger,
    this.flightReturnDate,
    this.flightclass,
    this.flightPrice,
    this.lowFarePrice,
    this.userEmail,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        flightAirline: json['flightAirline'],
        flightDepartureDate: json['flightDepartureDate'],
        flightFrom: json['flightFrom'],
        flightTo: json['flightTo'],
        flightPassenger: json['flightPassenger'],
        flightReturnDate: json['flightReturnDate'],
        flightclass: json['flightclass'],
        flightPrice: json['flightPrice'],
        lowFarePrice: json['lowFarePrice'],
        userEmail: json['userEmail'],
      );

  Map<String, dynamic> toJson() => {
        'flightAirline': flightAirline,
        'flightDepartureDate': flightDepartureDate,
        'flightFrom': flightFrom,
        'flightTo': flightTo,
        'flightPassenger': flightPassenger,
        'flightReturnDate': flightReturnDate,
        'flightclass': flightclass,
        'flightPrice': flightPrice,
        'lowFarePrice': lowFarePrice,
        'userEmail': userEmail,
      };
}
