import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/models/userUpdate.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/models/doctor.dart';
import 'package:hamro_doctor/models/user.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../constants/error_handeling.dart';
import '../../constants/globalvariable.dart';
import '../../constants/utils.dart';

class CommonService {
  Future<void> updateUser(
      BuildContext context,
      String? fullName,
      String? gender,
      String? dateOfBirth,
      String? email,
      String? phone,
      String? role,
      String? userimage,
      String? specialization,
      String? experience,
      String? education,
      String? fees,
      String? height,
      String? weight,
      String? bloodGroup,
      String? allergies,
      String? medicalHistory,
      String? currentMedication
      
      ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final id = userProvider.user.userId;
    try {
      UserUpdate userUpdate = UserUpdate(
        fullName: fullName,
        gender: gender,
        dateOfBirth: dateOfBirth,
        email: email,
        phone: phone,
        role: role,
        userimage: userimage,
        specialization: specialization,
        experience: experience,
        education: education,
        fees: fees,
        height: height,
        weight: weight,
        bloodGroup: bloodGroup,
        allergies: allergies,
        medicalHistory: medicalHistory,
        currentMedication: currentMedication,
      );
      http.Response res = await http.put(Uri.parse('$uri/api/update/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: userUpdate.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showCustomSnackBar(context, 'Account Has Been Updated!!!', true);
          });
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }
}
