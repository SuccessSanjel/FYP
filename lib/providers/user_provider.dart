import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      userId: '',
      fullName: '',
      password: '',
      email: '',
      phone: '',
      role: '',
      token: '',
      dateOfBirth:'',
      gender: '',
      );

  User get user => _user;

  void setUser(String user) {
  _user = User.fromJson(user);
  notifyListeners();
  }

}
