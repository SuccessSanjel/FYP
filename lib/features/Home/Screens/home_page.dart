import 'package:flutter/material.dart';
import 'package:hamro_doctor/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Center(
        child: Text(
          user.toJson(),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
