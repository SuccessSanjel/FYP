import 'package:flutter/material.dart';
import 'package:hamro_doctor/features/patients_feature/patient_services.dart';
import 'package:hamro_doctor/models/available_dates.dart';
import 'package:hamro_doctor/models/timing.dart';
import 'package:hamro_doctor/providers/patients_provider.dart';
import 'package:hamro_doctor/providers/user_provider.dart';

import 'package:provider/provider.dart';

import '../../constants/utils.dart';
import '../../models/doctor.dart';

class AppointmentBooking extends StatefulWidget {
  static const String routeName = '/appointment-booking';
  final Doctors doctor;

  final Timings timing;
  const AppointmentBooking({
    Key? key,
    required this.timing,
    required this.doctor,
  }) : super(key: key);

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  List<AvailableDates> availabledates = [];
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    fetchavailabletimes();
  }

  fetchavailabletimes() async {
    try {
      final availabletimes = await PatientService()
          .fetchavailabledates(context, widget.timing.timingId);
      setState(() {
        availabledates = availabletimes;
        if (availabledates.isNotEmpty) {
          selectedDate = availabledates[0].date;
        }
      });
    } catch (e) {
      showCustomSnackBar(context, e.toString(), false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientsProvider =
        Provider.of<PatientsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Appointment Time'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButton<String>(
                value: selectedDate,
                items: availabledates.map((AvailableDates date) {
                  return DropdownMenuItem<String>(
                    value: date.date,
                    child: Text(date.date),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDate = value!;
                  });
                },
                style: const TextStyle(color: Colors.black, fontSize: 18.0),
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.grey,
                iconSize: 30.0,
                underline: Container(
                  height: 0,
                ),
                hint: const Text(
                  'Select a date',
                  style: TextStyle(color: Colors.grey),
                ),
                isExpanded: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availabledates.length,
              itemBuilder: (BuildContext context, int index) {
                final date = availabledates[index];
                if (date.date != selectedDate) {
                  return Container(); // hide other dates
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: date.times.map((time) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Appointment'),
                                      content: Text(
                                        'Are you sure you want to book this appointment for ${widget.doctor.fees} RS?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await PatientService()
                                                .bookAppoinement(
                                              context: context,
                                              doctorID:
                                                  widget.doctor.doctorID ?? "",
                                              patientID: patientsProvider
                                                      .patients.patientid ??
                                                  "",
                                              date: selectedDate,
                                              time: time,
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  elevation: 4.0,
                                  child: Container(
                                    width: 200.0,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          time.substring(0, 5),
                                          style: const TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
