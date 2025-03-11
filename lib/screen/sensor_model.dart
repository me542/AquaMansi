import 'package:hive/hive.dart';

part 'sensor_model.g.dart';

@HiveType(typeId: 0)
class SensorModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String stage;

  @HiveField(3)
  bool enabled;

  @HiveField(4)
  String buttonName;

  SensorModel({
    required this.id,
    required this.name,
    required this.stage,
    required this.enabled,
    required this.buttonName,
  });

  /// Toggle enabled state and save changes
  void toggleEnabled() {
    enabled = !enabled;
    save();
  }

  /// Update stage and save changes
  void updateStage(String newStage) {
    stage = newStage;
    save();
  }
}
