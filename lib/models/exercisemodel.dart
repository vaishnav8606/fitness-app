import 'package:hive/hive.dart';

part 'exercisemodel.g.dart';

@HiveType(typeId: 0)
class Exercise extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int reps;

  @HiveField(2)
  int sets;

  @HiveField(3)
  int weight;

  Exercise({
    required this.name,
    this.reps = 0, 
    this.sets = 0,  
    this.weight = 0,
  });
}
