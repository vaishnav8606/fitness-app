// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterAdapter extends TypeAdapter<Water> {
  @override
  final int typeId = 1;

  @override
  Water read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Water(
      amount: fields[0] as double,
      timestamp: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Water obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
