// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  String? appointmentId;
  String? doctorId;
  String? patientId;
  String? date;
  String? time;
  String? status;
  String? paymenttype;
  Appointment({
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
    required this.paymenttype,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appointmentId': appointmentId,
      'doctorId': doctorId,
      'patientId': patientId,
      'date': date,
      'time': time,
      'status': status,
      'paymenttype': paymenttype,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      appointmentId: map['appointmentId'] != null ? map['appointmentId'] as String : null,
      doctorId: map['doctorId'] != null ? map['doctorId'] as String : null,
      patientId: map['patientId'] != null ? map['patientId'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      paymenttype: map['paymenttype'] != null ? map['paymenttype'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);

  Appointment copyWith({
    String? appointmentId,
    String? doctorId,
    String? patientId,
    String? date,
    String? time,
    String? status,
    String? paymenttype,
  }) {
    return Appointment(
      appointmentId: appointmentId ?? this.appointmentId,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      paymenttype: paymenttype ?? this.paymenttype,
    );
  }

  @override
  String toString() {
    return 'Appointment(appointmentId: $appointmentId, doctorId: $doctorId, patientId: $patientId, date: $date, time: $time, status: $status, paymenttype: $paymenttype)';
  }

  @override
  bool operator ==(covariant Appointment other) {
    if (identical(this, other)) return true;
  
    return 
      other.appointmentId == appointmentId &&
      other.doctorId == doctorId &&
      other.patientId == patientId &&
      other.date == date &&
      other.time == time &&
      other.status == status &&
      other.paymenttype == paymenttype;
  }

  @override
  int get hashCode {
    return appointmentId.hashCode ^
      doctorId.hashCode ^
      patientId.hashCode ^
      date.hashCode ^
      time.hashCode ^
      status.hashCode ^
      paymenttype.hashCode;
  }
}
