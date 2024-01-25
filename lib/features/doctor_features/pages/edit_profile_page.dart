import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hamro_doctor/common/services/common_service.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class DoctorProfileEdit extends StatefulWidget {
  static const String routeName = '/edit-profile-page';
  const DoctorProfileEdit({Key? key});

  @override
  State<DoctorProfileEdit> createState() => _DoctorProfileEditState();
}

class _DoctorProfileEditState extends State<DoctorProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  void updateUserMethod() async {
    CommonService commonService = CommonService();
    await commonService.updateUser(
      context,
      fullName ?? '',
      gender ?? '',
      dateOfBirth ?? '',
      email ?? '',
      phone ?? '',
      role ?? '',
      userimage ?? '',
      specialization ?? '',
      experience ?? '',
      education ?? '',
      fees ?? '',
      height ?? '',
      weight ?? '',
      bloodGroup ?? '',
      allergies ?? '',
      medicalHistory ?? '',
      currentMedication ?? '',
    );
  }

  String? fullName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phone;
  String? role;
  String? userimage;
  String? specialization;
  String? experience;
  String? education;
  String? fees;
  String? height;
  String? weight;
  String? bloodGroup;
  String? allergies;
  String? medicalHistory;
  String? currentMedication;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(labelText: userProvider.user.fullName),
                  onChanged: (value) => fullName = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  onChanged: (value) => gender = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  onChanged: (value) => dateOfBirth = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) => email = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onChanged: (value) => phone = value,
                ),
                if (userProvider.user.role == 'Doctor') ...[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Specialization'),
                    onChanged: (value) => specialization = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Education'),
                    onChanged: (value) => education = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Experience'),
                    onChanged: (value) => experience = value,
                  ),
                ],
                if (userProvider.user.role == 'Patient') ...[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Height'),
                    onChanged: (value) => height = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weight'),
                    onChanged: (value) => weight = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Allergies'),
                    onChanged: (value) => allergies = value,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Medical History'),
                    onChanged: (value) => medicalHistory = value,
                  ),
                ],
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      updateUserMethod();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
