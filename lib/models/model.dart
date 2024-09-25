import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Profiles extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  int height;

  @HiveField(4)
  int weight;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  int waterGoal;

  @HiveField(7)
  int stepGoal;

  @HiveField(8)
  String? profilePicturePath; 

  @HiveField(9)
  List<String>? imagePaths; 

  @HiveField(10)
  int? steps;

  @HiveField(11)
  double? distance;

  @HiveField(12)
  DateTime lastResetDate;

  @HiveField(13)
  double? currentWaterIntake;

  Profiles({
    required this.name,
    required this.username,
    required this.email,
    this.height = 0,
    this.weight =0,
    required this.gender,
     this.waterGoal =0,
    this.stepGoal =0,
    this.profilePicturePath,
    this.imagePaths, 
    this.steps = 0, 
    this.distance = 0.0, 
    DateTime? lastResetDate,
    this.currentWaterIntake = 0.0, 
  }) : lastResetDate = lastResetDate ?? DateTime.now(); 
}
