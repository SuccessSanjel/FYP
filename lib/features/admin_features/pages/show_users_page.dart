import 'package:flutter/material.dart';
import 'package:hamro_doctor/features/admin_features/pages/userdetail_page.dart';
import 'package:hamro_doctor/features/admin_features/services/add_user_service.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/user.dart';

class ShowAUsers extends StatefulWidget {
  static const String routeName = '/showusers-screen';
  const ShowAUsers({super.key});

  @override
  State<ShowAUsers> createState() => _ShowAUsersState();
}

class _ShowAUsersState extends State<ShowAUsers> {
  List<User>? users;
  final AddUserService addUserService = AddUserService();
  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  fetchAllUsers() async {
    users = await addUserService.fetchAllUsers(context);
    setState(() {});
  }

  void deleteUser(User user, int index) {
    addUserService.deleteUser(
        context: context,
        user: user,
        onSuccess: () {
          users!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return users == null
        ? const CustomProgressIndicator()
        : Scaffold(
            body: ListView.builder(
              itemCount: users!.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users![index];
                return GestureDetector(
                  onTap: () {
                    AddUserService().fetchuserdetails(
                      context: context,
                      role: user.role,
                      userID: user.userId, // pass the userID here
                    );
                    Navigator.pushNamed(context, UserDetail.routeName,
                        arguments: user);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Email: ${user.email}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Phone: ${user.phone}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Role: ${user.role}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Gender: ${user.gender}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Date of birth: ${user.dateOfBirth}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            child: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to delete this user?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteUser(user, index);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
