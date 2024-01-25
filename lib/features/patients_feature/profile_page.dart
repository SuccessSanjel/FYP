import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamro_doctor/features/auth/services/account_services.dart';
import 'package:hamro_doctor/features/doctor_features/pages/edit_profile_page.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:hamro_doctor/providers/patients_provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile-page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.user;
    final patientsProvider = Provider.of<PatientsProvider>(context);
    final patients = patientsProvider.patients;
    final role = users.role;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              itemProfile('Name', users.fullName, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Phone', users.phone, CupertinoIcons.phone),
              const SizedBox(height: 10),
              // itemProfile(
              //     'Address', 'abc address, xyz city', CupertinoIcons.location),
              // const SizedBox(height: 10),
              itemProfile('Email', users.email, CupertinoIcons.mail),
              const SizedBox(height: 10),
              itemProfile('Gender', users.gender, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile(
                  'Date of Birth', users.dateOfBirth, CupertinoIcons.calendar),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              if (role == 'Patient') ...[
                itemProfile('Height', patients.height ?? 'N/A',
                    CupertinoIcons.arrow_up),
                const SizedBox(height: 10),
                itemProfile('Weight', patients.weight ?? 'N/A',
                    CupertinoIcons.person_3_fill),
                const SizedBox(height: 10),
                itemProfile('Blood Group', patients.bloodGroup ?? 'N/A',
                    CupertinoIcons.heart),
                itemProfile('Allergies', patients.allergies ?? 'N/A',
                    CupertinoIcons.bandage),
                const SizedBox(height: 10),
                itemProfile('Medical History', patients.medicalHistory ?? 'N/A',
                    CupertinoIcons.doc_text),
                const SizedBox(height: 10),
                itemProfile('Current Medication',
                    patients.currentMedication ?? 'N/A', CupertinoIcons.pencil),
              ],

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, DoctorProfileEdit.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Edit Profile')),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AccountServices().logOut(context);
                                Navigator.of(context).pop(true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.all(15),
                              ),
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
