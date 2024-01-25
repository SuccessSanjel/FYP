import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserUpdate {
  String? fullName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phone;
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
  String? role;

  UserUpdate({
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.phone,
    this.userimage,
    this.specialization,
    this.experience,
    this.education,
    this.fees,
    this.height,
    this.weight,
    this.bloodGroup,
    this.allergies,
    this.medicalHistory,
    this.currentMedication,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'phone': phone,
      'userimage': userimage,
      'specialization': specialization,
      'experience': experience,
      'education': education,
      'fees': fees,
      'height': height,
      'weight': weight,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalHistory': medicalHistory,
      'currentMedication': currentMedication,
      'role': role,
    };
  }

  factory UserUpdate.fromMap(Map<String, dynamic> map) {
    return UserUpdate(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      userimage: map['userimage'] != null ? map['userimage'] as String : null,
      specialization: map['specialization'] != null
          ? map['specialization'] as String
          : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      fees: map['fees'] != null ? map['fees'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      bloodGroup:
          map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      allergies: map['allergies'] != null ? map['allergies'] as String : null,
      medicalHistory: map['medicalHistory'] != null
          ? map['medicalHistory'] as String
          : null,
      currentMedication: map['currentMedication'] != null
          ? map['currentMedication'] as String
          : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserUpdate.fromJson(String source) =>
      UserUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
