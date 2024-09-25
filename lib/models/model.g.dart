// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profiles> {
  @override
  final int typeId = 0;

  @override
  Profiles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profiles(
      name: fields[0] as String,
      username: fields[1] as String,
      email: fields[2] as String,
      height: fields[3] as int,
      weight: fields[4] as int,
      gender: fields[5] as String?,
      waterGoal: fields[6] as int,
      stepGoal: fields[7] as int,
      profilePicturePath: fields[8] as String?,
      imagePaths: (fields[9] as List?)?.cast<String>(),
      steps: fields[10] as int?,
      distance: fields[11] as double?,
      lastResetDate: fields[12] as DateTime?,
      currentWaterIntake: fields[13] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Profiles obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.waterGoal)
      ..writeByte(7)
      ..write(obj.stepGoal)
      ..writeByte(8)
      ..write(obj.profilePicturePath)
      ..writeByte(9)
      ..write(obj.imagePaths)
      ..writeByte(10)
      ..write(obj.steps)
      ..writeByte(11)
      ..write(obj.distance)
      ..writeByte(12)
      ..write(obj.lastResetDate)
      ..writeByte(13)
      ..write(obj.currentWaterIntake);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
