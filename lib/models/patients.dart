// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Patients {
  String? userId;
  String? height;
  String? weight;
  String? bloodGroup;
  String? allergies;
  String? medicalHistory;
  String? currentMedication;
  String? patientid;
  String? image;
  Patients({
    this.userId,
    this.height,
    this.weight,
    this.bloodGroup,
    this.allergies,
    this.medicalHistory,
    this.currentMedication,
    this.patientid,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'height': height,
      'weight': weight,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalHistory': medicalHistory,
      'currentMedication': currentMedication,
      'patientid': patientid,
      'image': image,
    };
  }

  factory Patients.fromMap(Map<String, dynamic> map) {
    return Patients(
      userId: map['userId'] != null ? map['userId'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      allergies: map['allergies'] != null ? map['allergies'] as String : null,
      medicalHistory: map['medicalHistory'] != null ? map['medicalHistory'] as String : null,
      currentMedication: map['currentMedication'] != null ? map['currentMedication'] as String : null,
      patientid: map['patientid'] != null ? map['patientid'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patients.fromJson(String source) =>
      Patients.fromMap(json.decode(source) as Map<String, dynamic>);

  Patients copyWith({
    String? userId,
    String? height,
    String? weight,
    String? bloodGroup,
    String? allergies,
    String? medicalHistory,
    String? currentMedication,
    String? patientid,
    String? image,
  }) {
    return Patients(
      userId: userId ?? this.userId,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      currentMedication: currentMedication ?? this.currentMedication,
      patientid: patientid ?? this.patientid,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Patients(userId: $userId, height: $height, weight: $weight, bloodGroup: $bloodGroup, allergies: $allergies, medicalHistory: $medicalHistory, currentMedication: $currentMedication, patientid: $patientid, image: $image)';
  }

  @override
  bool operator ==(covariant Patients other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.height == height &&
      other.weight == weight &&
      other.bloodGroup == bloodGroup &&
      other.allergies == allergies &&
      other.medicalHistory == medicalHistory &&
      other.currentMedication == currentMedication &&
      other.patientid == patientid &&
      other.image == image;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      bloodGroup.hashCode ^
      allergies.hashCode ^
      medicalHistory.hashCode ^
      currentMedication.hashCode ^
      patientid.hashCode ^
      image.hashCode;
  }
}
