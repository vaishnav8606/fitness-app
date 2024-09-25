import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin_workoutrecommendations.dart';
import 'package:flutter_application_1/screens/create_accound.dart';
import 'package:flutter_application_1/widgets/login_inputs.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/widgets/check_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String correctEmail = 'vaishnavravi8606@gmail.com';
  final String correctPassword = '1232580';
  final String adminemail = 'vaiahnavravi8606@gmail.com';
  final String adminpass ='12345678';
  final _formKey = GlobalKey<FormState>();
  bool _formSubmitted = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onInputChange);
    _passwordController.addListener(_onInputChange);
  }

  void _onInputChange() {
    if (_formSubmitted) {
      if (_formKey.currentState?.validate() == true) {
        setState(() {
          _formSubmitted = false;
        });
      }
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
       if (_emailController.text == adminemail && _passwordController.text == adminpass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const adminWorkoutRecommendationPage()),
      );
       } else if (_emailController.text == correctEmail &&
          _passwordController.text == correctPassword) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CheckLoginWidget(child: CustomNavbarWidget())),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/dumbbell.png'),
              ),
              const SizedBox(height: 30),
              const Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 80),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginInputs(
                      controller: _emailController,
                      label: 'Email ',
                      hint: "Enter your email address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    LoginInputs(
                      controller: _passwordController,
                      label: "Password",
                      hint: "Enter Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null ) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height:55,
                width: 120,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                      );
                    },
                    child: const Text('Sign up', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
  
}
