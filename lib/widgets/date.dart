import 'package:flutter_application_1/models/model.dart';
import 'package:hive/hive.dart';

Future<void> checkAndResetData() async {
  final box = await Hive.openBox<Profiles>('profiles');
  final profile = box.get('profile');

  if (profile != null) {
    final currentDate = DateTime.now();

    if (currentDate.difference(profile.lastResetDate).inDays >= 1) {
      profile.steps = 0;
      profile.distance = 0.0;
      profile.lastResetDate = currentDate;

      await profile.save();
    }
  }
}
