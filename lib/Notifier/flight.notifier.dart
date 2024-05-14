import 'package:explore_era/modal/flight.dart';
import 'package:flutter/foundation.dart';

class FlightNotifier extends ChangeNotifier {
  List<Flight> flightData = [];
  List<Flight> currentUserFlights = [];
  String flightPassenger = '00';
  String selectedAirLine = 'Emirates';
  String flightClass = 'Business Class';
  String flightFrom = 'PK';
  String flightTo = 'US';
  String flightDepartureDate = '';
  String flightReturnDate = '';

  void addFlightData(Flight flight) {
    flightData.add(flight);
    notifyListeners();
  }

  void clearFlightData(Flight flight) {
    flightData.removeWhere((element) => element.flightPrice == flight.flightPrice);
    notifyListeners();
  }

  void addCurrentUserFlights(Flight flight) {
    currentUserFlights.add(flight);
    notifyListeners();
  }

  void updateCurrentUserFlights(List<Flight> flights) {
    currentUserFlights = flights;
    notifyListeners();
  }

  void clearCurrentUserFlights(Flight flight) {
    currentUserFlights.removeWhere((element) => element.flightPrice == flight.flightPrice);
    flightData.removeWhere((element) => element.flightPrice == flight.flightPrice);
    notifyListeners();
  }

  void addFlightPassenger(String flightPassenger) {
    this.flightPassenger = flightPassenger;
    notifyListeners();
  }

  void addAirLine(String selectedAirLine) {
    this.selectedAirLine = selectedAirLine;
    notifyListeners();
  }

  void addFlightClass(String flightClass) {
    this.flightClass = flightClass;
    notifyListeners();
  }

  void addFlightFrom(String flightFrom) {
    this.flightFrom = flightFrom;
    notifyListeners();
  }

  void addFlightTo(String flightTo) {
    this.flightTo = flightTo;
    notifyListeners();
  }

  void addFlightDepartureDate(String flightDepartureDate) {
    this.flightDepartureDate = flightDepartureDate;
    notifyListeners();
  }

  void addFlightReturnDate(String flightReturnDate) {
    this.flightReturnDate = flightReturnDate;
    notifyListeners();
  }
}
