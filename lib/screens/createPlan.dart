import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercisemodel.dart';
import 'package:flutter_application_1/widgets/coustom_tab.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:flutter_application_1/widgets/premade_tab.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Createplan extends StatefulWidget {
  const Createplan({super.key});

  @override
  State<Createplan> createState() => _CreateplanState();
}

class _CreateplanState extends State<Createplan> {
  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    Hive.openBox<Exercise>('exercises');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomNavbarWidget()),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('Create Plans', style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Custom'),
              Tab(text: 'Pre-made'),
            ],
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
          ),
        ),
        body: TabBarView(
          children: [
            CustomTab(
              onExerciseAdded: () {
                setState(() {}); 
              },
            ),
            const PremadeTab(),
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
