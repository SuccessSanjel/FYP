import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/widgets/costom_text_field.dart';
import 'package:hamro_doctor/common/widgets/custom_button.dart';
import 'package:hamro_doctor/features/auth/screens/signup_page.dart';

import 'package:hamro_doctor/features/auth/services/sign_in_service.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin-screen';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signinFormKey = GlobalKey<FormState>();
  final SigninService signinService = SigninService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    signinService.signinUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signin to Hamro Doctor")),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _signinFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: "Sign In",
                    onTap: () {
                      if (_signinFormKey.currentState!.validate()) {
                        signInUser();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Signup Page",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignUpPage.routeName, (route) => false);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
