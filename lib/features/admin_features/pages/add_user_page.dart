import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_doctor/common/widgets/costom_text_field.dart';
import 'package:hamro_doctor/common/widgets/custom_button.dart';
import 'package:flutter/services.dart';
import '../../../common/widgets/custom_drop_down.dart';
import '../../../common/widgets/date_picker.dart';
import '../services/add_user_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/utils.dart';

class AddUserPage extends StatefulWidget {
  static const String routeName = '/adduser-screen';
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _adduserFormKey = GlobalKey<FormState>();
  final AddUserService addUserService = AddUserService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _retypepassword = TextEditingController();
  final TextEditingController _rolecontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _gendercontroller = TextEditingController();
  File? _userImage;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _retypepassword.dispose();
    _rolecontroller.dispose();
    _datecontroller.dispose();
    _gendercontroller.dispose();
  }

  void addUser() {
    if (_userImage == null) {
      showCustomSnackBar(context, 'Please select an image', false);
      return;
    }
    addUserService.addUser(
      context: context,
      email: _emailController.text,
      fullName: _nameController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      role: _rolecontroller.text,
      dateOfBirth: _datecontroller.text,
      gender: _gendercontroller.text,
      userImage: _userImage!,
    );
  }

  Future<void> _selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _adduserFormKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _selectImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _userImage != null ? FileImage(_userImage!) : null,
                    child: _userImage == null
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 16),
                CustomDatePicker(
                  label: "Date Of Birth",
                  controller: _datecontroller,
                  initialDate: DateTime.now(),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _retypepassword,
                  hintText: 'Confirm Password',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  items: const ['Admin', 'Patient', 'Doctor'],
                  value: 'Admin',
                  onChanged: (value) {
                    setState(() {
                      _rolecontroller.text = value;
                    });
                  },
                  hintText: 'Select a role',
                ),
                const SizedBox(height: 32),
                CustomDropdown(
                  items: const ['Male', 'Female', 'Other'],
                  value: 'Male',
                  onChanged: (value) {
                    setState(() {
                      _gendercontroller.text = value;
                    });
                  },
                  hintText: 'Gender',
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Add User',
                  onTap: () {
                    if (_passwordController.text != _retypepassword.text) {
                      showCustomSnackBar(
                          context, "Password Doesnt Match", false);
                      return;
                    }

                    if (_adduserFormKey.currentState!.validate()) {
                      addUser();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
