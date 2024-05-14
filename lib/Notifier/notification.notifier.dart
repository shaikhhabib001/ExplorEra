import 'package:explore_era/modal/flight.dart';
import 'package:flutter/foundation.dart';

class NotificationNotifier extends ChangeNotifier {
  List<Flight> notifications = [];
  List<Flight> currentUserNotification = [];

  void addNotifications(Flight flight) {
    notifications.add(flight);
    notifyListeners();
  }

  void clearNotifications(Flight flight) {
    notifications.removeWhere((element) => element.flightPrice == flight.flightPrice);
    notifyListeners();
  }

  void addCurrentUserNotification(Flight flight) {
    currentUserNotification.add(flight);
    notifyListeners();
  }

  void updateCurrentUserNotification(List<Flight> flights) {
    currentUserNotification = flights;
    notifyListeners();
  }

  void clearCurrentUserNotification(Flight flight) {
    currentUserNotification.removeWhere((element) => element.flightPrice == flight.flightPrice);
    notifyListeners();
  }
}
