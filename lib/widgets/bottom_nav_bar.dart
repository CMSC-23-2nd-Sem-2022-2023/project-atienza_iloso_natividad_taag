import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: GNav(
            mainAxisAlignment: MainAxisAlignment.center,
            color: Colors.grey[400],
            activeColor: Colors.grey.shade700,
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.grey.shade100,
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            curve: Curves.easeInOutExpo,
            tabBorderRadius: 30,
            haptic: true,
            gap: 8,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.person_3_outlined, text: 'Profile'),
              GButton(icon: Icons.admin_panel_settings_outlined ,text: 'Admin')
            ]),
      ),
    );
  }
}
