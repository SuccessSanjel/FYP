// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String userId;
  final String fullName;
  final String password;
  final String email;
  final String phone;
  final String role;
  String? token;
  final String dateOfBirth;
  final String gender;
  String? userimage;

  User({
    required this.userId,
    required this.fullName,
    required this.password,
    required this.email,
    required this.phone,
    required this.role,
    this.token,
    required this.dateOfBirth,
    required this.gender,
    this.userimage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullName': fullName,
      'password': password,
      'email': email,
      'phone': phone,
      'role': role,
      'token': token,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'userimage': userimage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      fullName: map['fullName'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      token: map['token'] != null ? map['token'] as String : null,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      userimage: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
