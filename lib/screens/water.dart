import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/models/watermodel.dart';
import 'package:flutter_application_1/widgets/home_grid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final TextEditingController _waterController = TextEditingController();
  late Box<Profiles> profiles;
  late Box<Water> waterBox;
  Profiles? profile;
  double _currentWaterIntake = 0.0;
  final double _totalWaterGoal = 5; 
  String _lastResetDate = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _checkAndResetWaterIntake();
  }

  Future<void> _loadProfileData() async {
    profiles = await Hive.openBox<Profiles>('profiles');
    waterBox = await Hive.openBox<Water>('water');
    setState(() {
      profile = profiles.get('profile');
      _currentWaterIntake = profile?.currentWaterIntake ?? 0.0;
    });
  }

  void _checkAndResetWaterIntake() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_lastResetDate != today) {
      setState(() {
        _lastResetDate = today;
        _currentWaterIntake = 0;
        waterBox.clear(); 
        profile?.currentWaterIntake = 0.0; 
        profile?.save(); 
      });
    }
  }

  void _addWaterIntake() {
    final addedWater = double.tryParse(_waterController.text) ?? 0;
    if (addedWater > 0) {
      setState(() {
        _currentWaterIntake += addedWater;

        final waterRecord = Water(
          amount: addedWater,
          timestamp: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        );
        waterBox.add(waterRecord);

        profile?.currentWaterIntake = _currentWaterIntake;
        profile?.save();
      });

      _waterController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'Water',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActivityCard(
              title: 'Water',
              progress: _currentWaterIntake,
              value: '$_currentWaterIntake',
              unit: 'L',
              total: _totalWaterGoal,
              icon: Icons.local_drink,
              onReset: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _waterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Add water intake (L)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: _addWaterIntake,
              child: const Text('Add Water'),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: waterBox.listenable(),
                builder: (context, Box<Water> box, _) {
                  final records = box.values.toList();

                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return ListTile(
                        title: Text('${record.amount} L', style: const TextStyle(color: Colors.white)),
                        subtitle: Text(record.timestamp, style: const TextStyle(color: Colors.white70)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
