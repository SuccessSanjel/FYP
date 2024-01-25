import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hamro_doctor/features/admin_features/services/add_user_service.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/appointments.dart';

class AllAppointments extends StatefulWidget {
  static const String routeName = '/all-appoitments';

  const AllAppointments({super.key});

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  List<Appointment>? appointments;
  final AddUserService addUserService = AddUserService();
  @override
  void initState() {
    super.initState();
    getAdminAppointments();
  }

  Future<void> getAdminAppointments() async {
    appointments = await addUserService.getAdminAppointments(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return appointments == null
        ? const CustomProgressIndicator()
        : Scaffold(
            body: ListView.builder(
              itemCount: appointments!.length,
              itemBuilder: (BuildContext context, int index) {
                final appointment = appointments![index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Color.fromARGB(
                        255, 17, 243, 255), // Set the desired color here
                    child: ListTile(
                      title:
                          Text('Appointment ID: ${appointment.appointmentId}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text('Doctor: ${appointment.doctorId}'),
                          Text('Patient: ${appointment.patientId}'),
                          Text('Date: ${appointment.date}'),
                          Text('Time: ${appointment.time}'),
                          Text('Status: ${appointment.status}'),
                          SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
