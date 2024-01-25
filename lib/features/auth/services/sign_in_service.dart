import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:hamro_doctor/common/bottom_bars/patients_bar.dart';

import 'package:hamro_doctor/constants/error_handeling.dart';
import 'package:hamro_doctor/constants/utils.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globalvariable.dart';

import 'package:http/http.dart' as http;

import '../../../providers/patients_provider.dart';

class SigninService {
  //sign up user

  void signinUser({
    required BuildContext context,
    required String email,
    required String password,
    //required String role,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (context.mounted) {}
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (context.mounted) {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          }

          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, PatientBar.routeName, (route) => false);
          }
        },
      );
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  void getUserData(
    BuildContext context,
    //required String role,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        if (context.mounted) {}
        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUser(userRes.body);
        var patientsProvider =
            Provider.of<PatientsProvider>(context, listen: false);
// Set the patient data in the provider
        // patientsProvider.setPatients(
        //     '{"patientid": "123", "fullName": "John Doe", "phone": "123-456-7890", "email": "johndoe@example.com", "userId": "456"}');

        var userData = jsonDecode(userRes.body);

        if (userData != null && userData['role'] == 'Patient') {
          http.Response patientRes = await http.get(
            Uri.parse('$uri/patients'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            },
          );
          var patientData = jsonDecode(patientRes.body);

// Accessing the fields for a patient
          String? patientId = patientData['patientId'];
          String? fullName = patientData['fullName'];
          String? phone = patientData['phone'];
          String? email = patientData['email'];
          String? userId = patientData['userId'];
          String? gender = patientData['gender'];
          String? height = patientData['heights'];
          String? weight = patientData['weight'];
          String? medicalHistory = patientData['medicalHistory'];
          String? currentMedication = patientData['currentMedication'];
          String? bloodGroup = patientData['bloodGroup'];
          String? allergies = patientData['allergies'];
          String? dateofbirth = patientData['dateOfBirth'];

          patientsProvider.setPatients(
              '{"dateOfBirth": "$dateofbirth","patientid": "$patientId", "fullName": "$fullName", "phone": "$phone", "email": "$email", "userId": "$userId", "height": "$height", "weight": "$weight", "medicalHistory": "$medicalHistory", "currentMedication": "$currentMedication", "bloodGroup": "$bloodGroup", "allergies": "$allergies","gender":"$gender"}');
        }
      }

      SchedulerBinding.instance.addPostFrameCallback((_) {});
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }
}
