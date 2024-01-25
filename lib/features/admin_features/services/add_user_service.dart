import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/constants/error_handeling.dart';
import 'package:hamro_doctor/constants/utils.dart';
import 'package:hamro_doctor/models/doctor.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/globalvariable.dart';
import '../../../../models/user.dart';
import 'package:http/http.dart' as http;

import '../../../models/appointments.dart';
import '../../../models/patients.dart';
import '../../../models/timing.dart';

class AddUserService {
  //sign up user
  void addUser({
    required BuildContext context,
    required String email,
    required String fullName,
    required String phone,
    required String password,
    required String role,
    required String gender,
    required String dateOfBirth,
    required File userImage,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // Create a new user instance
      User user = User(
        userId: '',
        fullName: fullName,
        password: password,
        email: email,
        phone: phone,
        role: role,
        gender: gender,
        dateOfBirth: dateOfBirth,
        token: '',
      );

      // Create a multipart request
      var request =
          http.MultipartRequest('POST', Uri.parse('$uri/admin/adduser'));

      // Add user data to the request fields
      request.fields['fullName'] = user.fullName;
      request.fields['password'] = user.password;
      request.fields['email'] = user.email;
      request.fields['phone'] = user.phone;
      request.fields['role'] = user.role;
      request.fields['gender'] = user.gender;
      request.fields['dateOfBirth'] = user.dateOfBirth;

      // Create a multipart file from the userImage
      var file = await http.MultipartFile.fromPath('userimage', userImage.path);

      // Add the file to the request
      request.files.add(file);

      // Set the authentication token header
      request.headers['x-auth-token'] = userProvider.user.token ?? "";

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

  Future<List<User>> fetchAllUsers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-users'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token ?? ""
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            userList.add(
              User.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
    return userList;
  }

  void deleteUser({
    required BuildContext context,
    required User user,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token ?? ""
        },
        body: jsonEncode({'userId': user.userId}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showCustomSnackBar(context, 'Account Has Been Deleted!!!', true);
        },
      );
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  Future<dynamic> fetchuserdetails({
    required BuildContext context,
    required String userID,
    required String role,
  }) async {
    Doctors? doctor;
    Patients? patient;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/$userID/user-detail'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token ?? ""
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final everydata = jsonDecode(res.body) as Map<String, dynamic>;

          if (role == "Doctor") {
            doctor = Doctors(
                specialization: everydata['specialization'] as String?,
                experience: everydata['experience'] as String?,
                education: everydata['education'] as String?,
                fees: everydata['fees'] as String?,
                rating: everydata['rating'] as String?,
                userId: everydata['userId'] as String?);
          }

          if (role == "Patient") {
            patient = Patients(
              height: everydata['height'] as String?,
              weight: everydata['weight'] as String?,
              bloodGroup: everydata['bloodGroup'] as String?,
              allergies: everydata['allergies'] as String?,
              medicalHistory: everydata['medicalHistory'] as String?,
              currentMedication: everydata['currentMedication'] as String?,
              userId: everydata['userId'] as String?,
            );
          }
        },
      );
      if (role == "Doctor") {
        return doctor;
      }
      if (role == "Patient") {
        return patient;
      }
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  Future<List<Timings>> fetchDoctorTiming(
    BuildContext context,
    String doctorID,
  ) async {
    List<Timings> timing = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/$doctorID/timings'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            timing.add(
              Timings.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      print(timing);
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
    return timing;
  }

  Future<List<Appointment>> getAdminAppointments(BuildContext context) async {
    List<Appointment> appointmentlist = [];
    final url = Uri.parse('$uri/get-appointments');

    try {
      http.Response res = await http.get(url);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            appointmentlist.add(
              Appointment.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
    return appointmentlist;
  }
}
