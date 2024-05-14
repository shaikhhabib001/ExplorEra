import 'package:explore_era/Notifier/flight.notifier.dart';
import 'package:explore_era/Notifier/notification.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:explore_era/Notifier/user.notifier.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => UserNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => FlightNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => NotificationNotifier(),
    ),
  ];
}
