import 'package:flutter/material.dart';
import 'package:modul7/hex_color.dart';
import 'package:modul7/profile.dart';
import 'package:modul7/viewmodel/home_user.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeUser(),
    // HomeUser(),
    // Settings(),
    Profile(),
    // Notifications(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      // Add a bottom navigation bar with four items.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor("FC997C"),
        selectedItemColor: Colors.white,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
