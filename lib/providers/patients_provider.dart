import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/models/patients.dart';

class PatientsProvider extends ChangeNotifier {
  Patients _patients = Patients(
    height: '',
    weight: '',
    medicalHistory: '',
    currentMedication: '',
    bloodGroup: '',
    allergies: '',
    patientid:'',
  );

  Patients get patients => _patients;

  void setPatients(String patients) {
    _patients = Patients.fromJson(patients);
    notifyListeners();
  }

  void clearPatients() {
    _patients = Patients(
      height: '',
      weight: '',
      medicalHistory: '',
      currentMedication: '',
      bloodGroup: '',
      allergies: '',
    );
    notifyListeners();
  }
}
