import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
        child: GNav(
            mainAxisAlignment: MainAxisAlignment.center,
            color: const Color.fromARGB(255, 60, 71, 81),
            activeColor: const Color.fromARGB(255, 0, 28, 53),
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: const Color.fromARGB(255, 209, 228, 255),
            backgroundColor: const Color.fromARGB(255, 240, 244, 250),
            curve: Curves.easeInOutExpo,
            tabBorderRadius: 30,
            haptic: true,
            gap: 8,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.person_3_outlined, text: 'Profile'),
              GButton(icon: Icons.admin_panel_settings_outlined ,text: 'Admin'),
              GButton(icon: Icons.request_page ,text: 'Requests'),
              GButton(icon: Icons.monitor ,text: 'Monitor')
            ]),
    );
  }
}
