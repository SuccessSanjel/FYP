import 'package:flutter/material.dart';
import 'package:hamro_doctor/features/admin_features/services/add_user_service.dart';
import 'package:hamro_doctor/models/patients.dart';
import 'package:hamro_doctor/models/timing.dart';

import '../../../constants/utils.dart';
import '../../../models/doctor.dart';
import '../../../models/user.dart';
import '../../patients_feature/patient_services.dart';

class UserDetail extends StatefulWidget {
  static const String routeName = '/user-detail';

  final User user;
  const UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  List<Timings> _timingsList = [];
  var _isLoading = true;
  Patients? _patient;
  Doctors? _doctor;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<dynamic> _fetchUserDetails() async {
    final result = await AddUserService().fetchuserdetails(
      context: context,
      userID: widget.user.userId,
      role: widget.user.role,
    );

    if (result != null) {
      if (result is Patients) {
        setState(() {
          _patient = result;
          _isLoading = false;
        });
        return _patient;
      } else if (result is Doctors) {
        setState(() {
          _doctor = result;
          _isLoading = false;
        });
        return _doctor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (widget.user.role == 'Doctor') {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.fullName),
        ),
        body: _doctor != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Email:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.user.email),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Phone:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.user.phone),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Date of Birth:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.user.dateOfBirth),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Doctor Information:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Specialization:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _doctor!.specialization ?? "",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Experience:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_doctor!.experience ?? ""),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Education:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_doctor!.education ?? ""),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Fees:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_doctor!.fees ?? ""),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Rating:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_doctor!.rating ?? ""),
                    const SizedBox(height: 8.0),
                    const Text(
                      'User ID:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_doctor!.userId ?? ""),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          _timingsList.length,
                          (index) {
                            final timing = _timingsList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
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
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    } else if (widget.user.role == 'Patient') {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.fullName),
        ),
        body: _patient != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Email: ${widget.user.email}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Phone: ${widget.user.phone}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Medical Information',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Height: ${_patient!.height ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Weight: ${_patient!.weight ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Blood Group: ${_patient!.bloodGroup ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Allergies: ${_patient!.allergies ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Medical History: ${_patient!.medicalHistory ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Current Medication: ${_patient!.currentMedication ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'User ID: ${_patient!.userId ?? ""}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.fullName),
        ),
        body: Center(
          child: Text('Error: Unknown user role - ${widget.user.role}'),
        ),
      ); // handle other roles or return an error message
    }
  }
}
