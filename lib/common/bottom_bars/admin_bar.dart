import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_doctor/features/admin_features/pages/Appointments.dart';
import 'package:hamro_doctor/features/admin_features/pages/add_user_page.dart';
import 'package:hamro_doctor/features/admin_features/pages/show_users_page.dart';
import 'package:hamro_doctor/features/patients_feature/profile_page.dart';

import '../../constants/globalvariable.dart';
import '../../features/Home/Screens/home_page.dart';

class AdminBar extends StatefulWidget {
  static const String routeName = '/admin-bar';
  const AdminBar({Key? key}) : super(key: key);

  @override
  State<AdminBar> createState() => _AdminBarState();
}

class _AdminBarState extends State<AdminBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const AllAppointments(),
    const ProfilePage(),
    const ShowAUsers(),
    const AddUserPage(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    switch (_page) {
      case 0:
        title = 'Home';
        break;
      case 1:
        title = 'Add User';
        break;
      case 2:
        title = 'Profile';
        break;
      case 3:
        title = 'All Users';
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.book,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_add_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
