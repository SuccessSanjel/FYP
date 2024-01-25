import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hamro_doctor/common/widgets/custom_button.dart';
import 'package:hamro_doctor/constants/utils.dart';
import 'package:hamro_doctor/features/patients_feature/appointment_booking_page.dart';
import 'package:hamro_doctor/features/patients_feature/patient_services.dart';

import '../../models/doctor.dart';
import '../../models/timing.dart';

class DoctorProfile extends StatefulWidget {
  static const String routeName = '/doctor-profile';

  final Doctors doctor;

  const DoctorProfile({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  List<Timings> _timingsList = [];

  @override
  void initState() {
    super.initState();
    _fetchTimings();
  }

  _fetchTimings() async {
    try {
      final timings = await PatientService()
          .fetchtiming(context, widget.doctor.doctorID ?? '');
      setState(() {
        _timingsList = timings;
      });
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor.fullName ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Doctor Profile',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Doctor ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.doctor.doctorID ?? ''),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Specialization:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.doctor.specialization ?? ''),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Experience:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.doctor.experience ?? ''),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Education:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.doctor.education ?? ''),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Fees:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.doctor.fees ?? ''),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Available Times:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _timingsList.length,
                    (index) {
                      final timing = _timingsList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppointmentBooking.routeName,
                                arguments: {
                                  'timing': timing,
                                  'doctor': widget.doctor
                                });
                          },
                          child: Card(
                            color: Color.fromARGB(255, 0, 192, 235),
                            elevation: 4.0,
                            child: Container(
                              width: 150.0,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(timing.day),
                                  const SizedBox(height: 8.0),
                                  Text(
                                      '${timing.starttime.substring(0, 5)} - ${timing.endtime.substring(0, 5)}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
