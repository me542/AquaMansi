import 'package:hive/hive.dart';

part 'stage_count.g.dart';

@HiveType(typeId: 2) // Different typeId for StageCount
class StageCount {
  @HiveField(0)
  String stage;

  @HiveField(1)
  int count;

  StageCount({required this.stage, required this.count});
}
