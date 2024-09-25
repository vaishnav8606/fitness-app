import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Profile.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:flutter_application_1/widgets/signout_warning.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Settings',),
        foregroundColor:  Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  const CustomNavbarWidget()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSettingsButton(
              context,
              icon: Icons.edit,
              label: 'Edit profile',
              color: Colors.cyan,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.lock,
              label: 'Privacy and policy',
              color: Colors.cyan,
              onTap: () {
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.description,
              label: 'Terms and condition',
              color: Colors.cyan,
              onTap: () {
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.info,
              label: 'About us',
              color: Colors.cyan,
              onTap: () {
               
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.exit_to_app,
              label: 'Sign out',
              color: Colors.red,
              onTap: () {
              showDialog(context: context, builder:(BuildContext context){
                return const SignoutWarning();
              }
              );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Icon(icon, color: color),
            title: Text(label, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
