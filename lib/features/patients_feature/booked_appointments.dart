import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/widgets/loader.dart';
import 'package:hamro_doctor/features/patients_feature/patient_services.dart';
import 'package:hamro_doctor/models/appointments.dart';

class BookedAppointments extends StatefulWidget {
  static const String routeName = '/booked-appointments';
  const BookedAppointments({Key? key}) : super(key: key);

  @override
  State<BookedAppointments> createState() => _BookedAppointmentsState();
}

class _BookedAppointmentsState extends State<BookedAppointments> {
  List<Appointment>? appointments;
  final PatientService patientService = PatientService();

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  Future<void> getAppointments() async {
    appointments = await patientService.getAppointments(context);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return appointments == null
        ? const CustomProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Booked Appointments'),
            ),
            body: ListView.builder(
              itemCount: appointments!.length,
              itemBuilder: (BuildContext context, int index) {
                final appointment = appointments![index];
                return Card(
                  elevation: 2, // Add elevation for a slight shadow effect
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8), // Add some margin around the card
                  child: ListTile(
                    title: Text(
                      'Appointment ID: ${appointment.appointmentId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height: 8), // Add some spacing between elements
                        Text(
                          'Doctor: ${appointment.doctorId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Patient: ${appointment.patientId}'),
                        Text('Date: ${appointment.date}'),
                        Text('Time: ${appointment.time}'),
                        const SizedBox(
                            height: 8), // Add some spacing between elements
                        Text(
                          'Status: ${appointment.status}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appointment.status == 'Pending'
                                ? Colors.orange
                                : appointment.status == 'Confirmed'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
