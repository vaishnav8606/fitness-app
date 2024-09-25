import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application_1/screens/activity.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/settings.dart';
import 'package:flutter_application_1/screens/water.dart';

class CustomNavbarWidget extends StatefulWidget {
  const CustomNavbarWidget({super.key});

  @override
  _CustomNavbarWidgetState createState() => _CustomNavbarWidgetState();
}

class _CustomNavbarWidgetState extends State<CustomNavbarWidget> {
  int _selectedIndex = 0;

  // List of pages to navigate
  final List<Widget> _pages = [
    const HomePage(),
    const WaterScreen(),
    const ActivityScreen(),
    const SettingsPage(),
  ];

  // Method to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Container(
        color: Colors.black, // Navbar background color
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.lightBlue,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8, // Space between icon and text
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.local_drink,
              text: 'Water',
            ),
            GButton(
              icon: Icons.add_circle,
              text: 'Activity',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
