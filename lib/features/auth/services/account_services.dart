import 'package:flutter/material.dart';
import 'package:hamro_doctor/constants/utils.dart';
import 'package:hamro_doctor/features/auth/screens/signin_page.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/patients_provider.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');

      final patientsProvider =
          Provider.of<PatientsProvider>(context, listen: false);
      patientsProvider.clearPatients();

      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInPage.routeName,
        (route) => false,
      );
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }
}
