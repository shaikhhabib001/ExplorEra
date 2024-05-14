import 'package:flutter/cupertino.dart';
import 'package:explore_era/modal/user.dart';

class UserNotifier extends ChangeNotifier {
  // ? all clauses list
  User user = User();

  void adduser(User user) {
    this.user = user;
    notifyListeners();
  }
}
