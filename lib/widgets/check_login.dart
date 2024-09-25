import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:flutter_application_1/widgets/permisson.dart';

class CheckLoginWidget extends StatefulWidget {
  final Widget child;

  const CheckLoginWidget({required this.child, super.key});

  @override
  State<CheckLoginWidget> createState() => _CheckLoginWidgetState();
}

class _CheckLoginWidgetState extends State<CheckLoginWidget> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      isLoggedIn = loggedIn;
    });

    if (isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PermissionWidget(child: CustomNavbarWidget())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    if (isLoggedIn == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return widget.child;
  }
}
