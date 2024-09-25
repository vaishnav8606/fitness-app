import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercisemodel.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/models/watermodel.dart';
import 'package:flutter_application_1/screens/splash.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<Profiles>(ProfileAdapter());
  await Hive.openBox<Profiles>('profiles');

  Hive.registerAdapter(ExerciseAdapter());
  await Hive.openBox<Exercise>('exercises');

  Hive.registerAdapter(WaterAdapter());
  await Hive.openBox<Water>('water'); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
