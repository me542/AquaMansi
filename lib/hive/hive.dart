import 'package:hive/hive.dart';

void saveData(int executions, int interval) async {
  var box = await Hive.openBox('settingsBox');
  await box.put('executions', executions);
  await box.put('interval', interval);
}

Future<Map<String, int>> loadData() async {
  var box = await Hive.openBox('settingsBox');
  int executions = box.get('executions', defaultValue: 0);
  int interval = box.get('interval', defaultValue: 0);
  return {'executions': executions, 'interval': interval};
}
