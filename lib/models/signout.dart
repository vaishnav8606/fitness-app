import 'package:flutter_application_1/models/model.dart';
import 'package:hive/hive.dart';

Future<void> signOut() async {
  
  final box = await Hive.openBox<Profiles>('profiles');
  
  
  await box.clear();
}
