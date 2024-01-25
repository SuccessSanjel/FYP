import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/widgets/loader.dart';
import 'package:hamro_doctor/features/patients_feature/patient_services.dart';
import 'package:hamro_doctor/models/doctor.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import 'doctor_profile_page.dart';

class PatientHome extends StatefulWidget {
  static const String routeName = '/patient-home-page';
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  List<Doctors>? doctors;
  final PatientService patientService = PatientService();

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  fetchDoctors() async {
    doctors = await patientService.fetchDoctors(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return doctors == null
        ? const CustomProgressIndicator()
        : Scaffold(
            appBar: AppBar(title: const Text("HomePage")),
            body: ListView.builder(
                itemCount: doctors!.length,
                itemBuilder: (BuildContext context, int index) {
                  final doctor = doctors![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DoctorProfile.routeName,
                        arguments: doctor,
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 70, 215, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.fullName ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              doctor.userId ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Experience: ${doctor.experience ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Specializaiton: ${doctor.specialization ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Fees: ${doctor.fees ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}
