import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignoutWarning extends StatelessWidget {
  const SignoutWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Sign out of your account?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Sign out'),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            );
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
