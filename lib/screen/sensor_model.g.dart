// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SensorModelAdapter extends TypeAdapter<SensorModel> {
  @override
  final int typeId = 0;

  @override
  SensorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SensorModel(
      id: fields[0] as int,
      name: fields[1] as String,
      stage: fields[2] as String,
      enabled: fields[3] as bool,
      buttonName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SensorModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.stage)
      ..writeByte(3)
      ..write(obj.enabled)
      ..writeByte(4)
      ..write(obj.buttonName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
