import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/models/appointments.dart';
import 'package:hamro_doctor/models/available_dates.dart';
import 'package:hamro_doctor/models/doctor.dart';
import 'package:hamro_doctor/providers/patients_provider.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../constants/error_handeling.dart';
import '../../constants/globalvariable.dart';
import '../../constants/utils.dart';
import '../../models/timing.dart';

class PatientService {
//final userProvider = Provider.of<UserProvider>(context, listen: false);

  Future<List<Doctors>> fetchDoctors(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Doctors> doctorList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-doctors'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token ?? ""
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            doctorList.add(
              Doctors.fromJson(
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
    return doctorList;
  }

  Future<List<Timings>> fetchtiming(BuildContext context, String id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Timings> timelist = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/$id/timings'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token ?? ""
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            timelist.add(
              Timings.fromJson(
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

    return timelist;
  }

  Future<List<AvailableDates>> fetchavailabledates(
      BuildContext context, String timeId) async {
    List<AvailableDates> availabletimelist = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/$timeId/gettimes'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> data = json.decode(res.body)['availableTimes'];
          for (var date in data) {
            String dateStr = date['date'];
            List<String> timesList = List<String>.from(date['times']);
            availabletimelist
                .add(AvailableDates(date: dateStr, times: timesList));
          }
        },
      );
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }

    return availabletimelist;
  }

  bookAppoinement({
    required BuildContext context,
    required String doctorID,
    required String patientID,
    required String date,
    required String time,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Appointment appointment = Appointment(
          appointmentId: '',
          doctorId: doctorID,
          patientId: patientID,
          date: date,
          time: time,
          status: '',
          paymenttype: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/post-appointment'),
        body: appointment.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token ?? "",
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showCustomSnackBar(
                context, 'Appointment Successfully Booked', true);
          });
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  Future<List<Appointment>> getAppointments(BuildContext context) async {
    final patientProvider =
        Provider.of<PatientsProvider>(context, listen: false);
    var patientId = patientProvider.patients.patientid;
    List<Appointment> appointmentlist = [];
    final url = Uri.parse('$uri/api/$patientId/get-appointments');

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
