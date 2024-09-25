import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/screens/admin_workoutrecommendations.dart';
import 'package:flutter_application_1/widgets/home_grid.dart';
import 'package:flutter_application_1/widgets/step_tracker.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Profiles> profiles;
  Profiles? profile;
  final int _calorie = 0;
  int _steps = 0;
  double _distance = 0.0;
  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    profiles = await Hive.openBox<Profiles>('profiles');
    profile = profiles.get('profile');

    setState(() {
      _isProfileLoaded = true;
    });
  }

  void _onStepUpdate(int steps, double distance) {
    setState(() {
      _steps = steps;
      _distance = distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('EEEE dd').format(DateTime.now());
    String? imagePath = profile?.profilePicturePath;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homeimage.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromARGB(255, 209, 207, 207),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            _isProfileLoaded
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        backgroundColor: Colors.lightBlue.withOpacity(0.5),
                        expandedHeight: 70,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          background: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundImage: imagePath != null &&
                                          imagePath.isNotEmpty
                                      ? FileImage(File(imagePath))
                                      : const AssetImage(
                                          'assets/default_avatar.png')
                                          as ImageProvider,
                                  radius: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              const SizedBox(height: 20),
                              const Text(
                                "Your Activity",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              StepTracker(onStepUpdate: _onStepUpdate),
                              const SizedBox(height: 20),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                children: _buildGridItems(),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const adminWorkoutRecommendationPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 35, 32, 32),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text(
                                    'Get Workout Recommendations',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGridItems() {
    if (profile != null) {
      return [
        ActivityCard(
          title: 'Walk',
          value: '$_steps',
          unit: 'Steps',
          progress: _steps.toDouble(),
          total: profile?.stepGoal.toDouble() ?? 10000.0, 
          icon: Icons.assist_walker, onReset: () {  },
        ),
        ActivityCard(
          title: 'Water',
          value: profile!.currentWaterIntake?.toStringAsFixed(1) ?? '0.0',
          unit: 'Liters',
          progress: profile?.currentWaterIntake ?? 0.0,
          total: profile?.waterGoal.toDouble() ?? 3.0,
          icon: Icons.water, onReset: () {  },
        ),
        ActivityCard(
          title: 'Calories',
          value: _calorie.toString(),
          unit: 'Unit',
          progress: 1300.0,
          total: 2800.0,
          icon: Icons.fire_hydrant, onReset: () {  },
        ),
        ActivityCard(
          title: 'Distance',
          value: _distance.toStringAsFixed(2),
          unit: 'km',
          progress: _distance,
          total: 10.0,
          icon: Icons.social_distance, onReset: () {  },
        ),
      ];
    } else {
      return [
        ActivityCard(
          title: 'Walk',
          value: '$_steps',
          unit: 'Steps',
          progress: _steps.toDouble(),
          total: 10000.0,
          icon: Icons.assist_walker, onReset: () {  },
        ),
        ActivityCard(
          title: 'Water',
          value: '2.7',
          unit: 'Liters',
          progress: 2.7,
          total: 3.0,
          icon: Icons.water, onReset: () {  },
        ),
        ActivityCard(
          title: 'Calories',
          value: '1300',
          unit: 'Unit',
          progress: 1300.0,
          total: 2800.0,
          icon: Icons.fire_hydrant, onReset: () {  },
        ),
        ActivityCard(
          title: 'Distance',
          value: _distance.toStringAsFixed(2),
          unit: 'km',
          progress: _distance,
          total: 10.0,
          icon: Icons.social_distance, onReset: () {  },
        ),
      ];
    }
  }
}
