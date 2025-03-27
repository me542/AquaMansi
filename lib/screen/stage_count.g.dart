// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_count.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StageCountAdapter extends TypeAdapter<StageCount> {
  @override
  final int typeId = 2;

  @override
  StageCount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StageCount(
      stage: fields[0] as String,
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StageCount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stage)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StageCountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
