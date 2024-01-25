import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/bottom_bars/admin_bar.dart';
import 'package:hamro_doctor/common/bottom_bars/doctors_bar.dart';
import 'package:hamro_doctor/common/bottom_bars/patients_bar.dart';
import 'package:hamro_doctor/features/Home/Screens/home_page.dart';
import 'package:hamro_doctor/features/admin_features/pages/Appointments.dart';
import 'package:hamro_doctor/features/admin_features/pages/add_user_page.dart';
import 'package:hamro_doctor/features/admin_features/pages/show_users_page.dart';
import 'package:hamro_doctor/features/admin_features/pages/userdetail_page.dart';
import 'package:hamro_doctor/features/auth/screens/signup_page.dart';
import 'package:hamro_doctor/features/doctor_features/pages/edit_profile_page.dart';
import 'package:hamro_doctor/features/patients_feature/appointment_booking_page.dart';
import 'package:hamro_doctor/features/patients_feature/booked_appointments.dart';
import 'package:hamro_doctor/features/patients_feature/doctor_profile_page.dart';
import 'package:hamro_doctor/features/patients_feature/patient_home_page.dart';
import 'package:hamro_doctor/features/patients_feature/profile_page.dart';
import 'package:hamro_doctor/models/appointments.dart';
import 'package:hamro_doctor/models/doctor.dart';
import 'package:hamro_doctor/models/timing.dart';
import 'package:hamro_doctor/models/user.dart';

import 'features/auth/screens/signin_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpPage(),
      );
    case SignInPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInPage(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case PatientBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PatientBar(),
      );

    case AdminBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DoctorBar(),
      );

    case DoctorBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DoctorBar(),
      );

    case UserDetail.routeName:
      var user = routeSettings.arguments as User;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UserDetail(user: user),
      );

    case AddUserPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddUserPage(),
      );
    case ProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfilePage(),
      );

    case ShowAUsers.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ShowAUsers(),
      );

    case DoctorProfile.routeName:
      var doctor = routeSettings.arguments as Doctors;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DoctorProfile(doctor: doctor),
      );

    case PatientHome.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PatientHome(),
      );

    case AppointmentBooking.routeName:
      var timing = (routeSettings.arguments as Map<String, dynamic>)['timing']
          as Timings;
      var doctor = (routeSettings.arguments as Map<String, dynamic>)['doctor']
          as Doctors;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppointmentBooking(
          timing: timing,
          doctor: doctor,
        ),
      );

    case DoctorProfileEdit.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DoctorProfileEdit(),
      );

    case BookedAppointments.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BookedAppointments(),
      );
    case AllAppointments.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllAppointments(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen Doesnt Exist'),
          ),
        ),
      );
  }
}
