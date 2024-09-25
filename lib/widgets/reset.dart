import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:hive/hive.dart';

class DailyDataResetWidget extends StatefulWidget {
  final Function(int) onReset;

  const DailyDataResetWidget({super.key, required this.onReset});

  @override
  _DailyDataResetWidgetState createState() => _DailyDataResetWidgetState();
}

class _DailyDataResetWidgetState extends State<DailyDataResetWidget> {
  late Box<Profiles> profiles;
  Profiles? profile;

  @override
  void initState() {
    super.initState();
    _checkAndResetData();
  }

  Future<void> _checkAndResetData() async {
    profiles = await Hive.openBox<Profiles>('profiles');
    profile = profiles.get('profile');

    if (profile != null) {
      final today = DateTime.now();
      final lastReset = profile!.lastResetDate;

      // Debugging logs for better insight
      print("Today's date: $today");
      print("Last reset date from profile: $lastReset");

      // Reset if it's a new day
      if ( !_isSameDay(lastReset, today)) {
        print("Data has been reset. Last reset date updated to: $today");
        
        // Reset the daily data
        widget.onReset(0);

        // Update the lastResetDate to today
        profile!.lastResetDate = today;

        // Persist the updated profile with the new reset date
        await profiles.put('profile', profile!);

        // Update the state in case needed
        setState(() {});
      } else {
        print("No reset needed. Last reset was on: $lastReset");
      }
    } else {
      print("No profile found to reset.");
    }
  }

  // Utility function to compare if two dates are on the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // This widget doesn't display anything
  }
}
