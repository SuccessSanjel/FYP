import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/constants/error_handeling.dart';
import 'package:hamro_doctor/constants/utils.dart';
import '../../../constants/globalvariable.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class SignupService {
  void signupUser({
    required BuildContext context,
    required String email,
    required String fullName,
    required String phone,
    required String password,
    required String gender,
    required String dateOfBirth,
    required File userImage,
  }) async {
    try {
      User user = User(
        userId: '',
        fullName: fullName,
        password: password,
        email: email,
        phone: phone,
        gender: gender,
        dateOfBirth: dateOfBirth,
        role: '',
        token: '',
      );

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse('$uri/api/signup'));

      // Add user data to the request fields
      request.fields['fullName'] = user.fullName;
      request.fields['password'] = user.password;
      request.fields['email'] = user.email;
      request.fields['phone'] = user.phone;
      request.fields['gender'] = user.gender;
      request.fields['dateOfBirth'] = user.dateOfBirth;

      // Create a multipart file from the userImage
      var file = await http.MultipartFile.fromPath('userimage', userImage.path);

      // Add the file to the request
      request.files.add(file);

      // Send the request
      var response = await request.send();

      // Get the response body as a string
      var responseData = await response.stream.bytesToString();

      // Handle the response
      if (response.statusCode == 200) {
        // Successful signup
        showCustomSnackBar(context, 'Account has been created!', true);
      } else {
        // Error occurred
        showCustomSnackBar(context, responseData, false);
      }
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }
}
