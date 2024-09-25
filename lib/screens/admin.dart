import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  final Map<String, List<Map<String, String>>> recommendations;

  const AdminPage({super.key, required this.recommendations});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Map<String, List<Map<String, String>>> _recommendations;

  @override
  void initState() {
    super.initState();
    _recommendations = widget.recommendations;
  }

  void _updateRecommendation(String bodyPart, String difficulty, String newRecommendation) {
    setState(() {
      final index = _recommendations[bodyPart]!.indexWhere((element) => element.containsKey(difficulty));
      if (index != -1) {
        _recommendations[bodyPart]![index][difficulty] = newRecommendation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workout Recommendations'),
      ),
      body: ListView(
        children: _recommendations.entries.map((entry) {
          final bodyPart = entry.key;
          final difficulties = entry.value;
          return ExpansionTile(
            title: Text(bodyPart),
            children: difficulties.map((difficultyMap) {
              final difficulty = difficultyMap.keys.first;
              final recommendation = difficultyMap[difficulty]!;
              return ListTile(
                title: Text(difficulty),
                subtitle: Text(recommendation),
                onTap: () async {
                  final newRecommendation = await _showEditDialog(context, recommendation);
                  if (newRecommendation != null) {
                    _updateRecommendation(bodyPart, difficulty, newRecommendation);
                  }
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Future<String?> _showEditDialog(BuildContext context, String currentRecommendation) async {
    final TextEditingController controller = TextEditingController(text: currentRecommendation);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Recommendation'),
          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Enter new recommendation',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
