// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/bottom_bars/patients_bar.dart';
import 'package:hamro_doctor/constants/globalvariable.dart';
import 'package:hamro_doctor/features/Home/Screens/home_page.dart';
import 'package:hamro_doctor/features/auth/screens/signup_page.dart';
import 'package:hamro_doctor/features/auth/services/sign_in_service.dart';
import 'package:hamro_doctor/providers/patients_provider.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:hamro_doctor/router.dart';
import 'package:provider/provider.dart';
import 'common/bottom_bars/admin_bar.dart';
import 'common/bottom_bars/doctors_bar.dart';
import 'features/auth/screens/signin_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider<PatientsProvider>(
          create: (_) => PatientsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SigninService signinService = SigninService();
  @override
  void initState() {
    super.initState();
    signinService.getUserData(context);
    //signinService.getPatientData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hamro Doctor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.role == 'patients'
      //       ? const PatientBar()

      //       : const SignInPage(),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.user;
          if (user.token?.isNotEmpty == true) {
            if (user.role == 'Admin') {
              return const AdminBar();
            } else if (user.role == 'Patient') {
              return const PatientBar();
            } else if (user.role == 'Doctor') {
              return const DoctorBar();
            } else {
              // If the user role is not recognized, you can return an appropriate widget or null
              return const Text('Unknown role');
            }
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
