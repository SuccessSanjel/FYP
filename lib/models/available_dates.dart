import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AvailableDates {
  String date;
  List<String> times;
  AvailableDates({
    required this.date,
    required this.times,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'times': times,
    };
  }

  factory AvailableDates.fromMap(Map<String, dynamic> map) {
    return AvailableDates(
        date: map['date'] as String,
        times: List<String>.from(
          (map['times'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AvailableDates.fromJson(String source) =>
      AvailableDates.fromMap(json.decode(source) as Map<String, dynamic>);
}
