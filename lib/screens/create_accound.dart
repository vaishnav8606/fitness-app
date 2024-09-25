import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_application_1/widgets/login_inputs.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: Image.asset('assets/dumbbell.png'),
              ),
              const Text(
                "Create a New Account",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginInputs(
                      controller: _nameController,
                      label: 'Name',
                      hint: "Enter your name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    LoginInputs(
                      controller: _usernameController,
                      label: 'Username',
                      hint: "Enter your username",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    LoginInputs(
                      controller: _emailController,
                      label: 'Email',
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    LoginInputs(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Re-enter Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newProfile = Profiles(
                      name: _nameController.text,
                      username: _usernameController.text,
                      email: _emailController.text,
                      height: 170,  
                      weight: 70,  
                      gender: 'Male', 
                      waterGoal: 3, 
                      stepGoal: 10000,  
                      profilePicturePath: '',
                      imagePaths: [],
                    );

                    try {
                      final box = await Hive.openBox<Profiles>('profiles');
                      await box.put('profile', newProfile);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    } catch (e) {
                      print('Error: $e');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
