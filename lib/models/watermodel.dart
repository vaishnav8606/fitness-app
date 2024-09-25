import 'package:hive/hive.dart';

part 'watermodel.g.dart';

@HiveType(typeId: 1)
class Water extends HiveObject {
  @HiveField(0)
  double? amount;

  @HiveField(1)
  String timestamp;

  Water({
     this.amount=0.0,
    required this.timestamp,
  });
}
