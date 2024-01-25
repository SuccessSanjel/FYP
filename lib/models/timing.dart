// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Timings {
  String timingId;
  String doctorId;
  String day;
  String starttime;
  String endtime;
  Timings({
    required this.timingId,
    required this.doctorId,
    required this.day,
    required this.starttime,
    required this.endtime,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timingId': timingId,
      'doctorId': doctorId,
      'day': day,
      'starttime': starttime,
      'endtime': endtime,
    };
  }

  factory Timings.fromMap(Map<String, dynamic> map) {
    return Timings(
      timingId: map['timingId'] as String,
      doctorId: map['doctorId'] as String,
      day: map['day'] as String,
      starttime: map['starttime'] as String,
      endtime: map['endtime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timings.fromJson(String source) => Timings.fromMap(json.decode(source) as Map<String, dynamic>);
}
