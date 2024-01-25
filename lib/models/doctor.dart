import 'dart:convert';

//'fullname', 'email','phone','dateOfBirth','gender'
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Doctors {
  String? fullName;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? gender;
  String? image;
  String? userId;
  String? specialization;
  String? experience;
  String? education;
  String? fees;
  String? rating;
  String? doctorID;

  Doctors({
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.image,
    this.userId,
    this.specialization,
    this.experience,
    this.education,
    this.fees,
    this.rating,
    this.doctorID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'image': image,
      'userId': userId,
      'specialization': specialization,
      'experience': experience,
      'education': education,
      'fees': fees,
      'rating': rating,
      'doctorID': doctorID,
    };
  }

  factory Doctors.fromMap(Map<String, dynamic> map) {
    return Doctors(
      fullName: map['user']['fullname'] != null
          ? map['user']['fullname'] as String
          : null,
      email:
          map['user']['email'] != null ? map['user']['email'] as String : null,
      phone:
          map['user']['phone'] != null ? map['user']['phone'] as String : null,
      dateOfBirth: map['user']['dateOfBirth'] != null
          ? map['user']['dateOfBirth'] as String
          : null,
      gender: map['user']['gender'] != null
          ? map['user']['gender'] as String
          : null,
      image: map['image'] != null ? map['image'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      specialization: map['specialization'] != null
          ? map['specialization'] as String
          : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      fees: map['fees'] != null ? map['fees'] as String : null,
      rating: map['rating'] != null ? map['rating'] as String : null,
      doctorID: map['doctorId'] != null ? map['doctorId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctors.fromJson(String source) =>
      Doctors.fromMap(json.decode(source) as Map<String, dynamic>);

  Doctors copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? image,
    String? userId,
    String? specialization,
    String? experience,
    String? education,
    String? fees,
    String? rating,
    String? doctorID,
  }) {
    return Doctors(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      fees: fees ?? this.fees,
      rating: rating ?? this.rating,
      doctorID: doctorID ?? this.doctorID,
    );
  }

  @override
  String toString() {
    return 'Doctors(fullName: $fullName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, gender: $gender, image: $image, userId: $userId, specialization: $specialization, experience: $experience, education: $education, fees: $fees, rating: $rating, doctorID: $doctorID)';
  }

  @override
  bool operator ==(covariant Doctors other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.email == email &&
        other.phone == phone &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.image == image &&
        other.userId == userId &&
        other.specialization == specialization &&
        other.experience == experience &&
        other.education == education &&
        other.fees == fees &&
        other.rating == rating &&
        other.doctorID == doctorID;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        image.hashCode ^
        userId.hashCode ^
        specialization.hashCode ^
        experience.hashCode ^
        education.hashCode ^
        fees.hashCode ^
        rating.hashCode ^
        doctorID.hashCode;
  }
}
