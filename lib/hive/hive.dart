import 'package:hive/hive.dart';
import 'package:Aquamansi/screen/sensor_model.dart';
import 'package:Aquamansi/screen/stage_count.dart';  // Import the StageCount model

class HiveService {
  static bool _isInitialized = false;

  static late Box<SensorModel> _sensorsBox;
  static late Box<int> _executionCountBox;
  static late Box<int> _settingsBox;
  static late Box<List<Map<String, String>>> _dataBox; // Box for storing WebSocket data (updated to store List<Map<String, String>>)
  static late Box<StageCount> _stageCountBox; // Box for storing stage counts

  /// Initialize Hive and register adapters
  static Future<void> init() async {
    if (_isInitialized) return;

    // Register adapters only once
    if (!Hive.isAdapterRegistered(SensorModelAdapter().typeId)) {
      Hive.registerAdapter(SensorModelAdapter());
    }

    if (!Hive.isAdapterRegistered(StageCountAdapter().typeId)) {
      Hive.registerAdapter(StageCountAdapter());
    }

    // Open the boxes
    _sensorsBox = await _openBox<SensorModel>('sensors');
    _executionCountBox = await _openBox<int>('execution_count');
    _settingsBox = await _openBox<int>('settings');
    _dataBox = await _openBox<List<Map<String, String>>>('data'); // Change type here
    _stageCountBox = await _openBox<StageCount>('stage_count');

    _isInitialized = true;

    // Debug: Log stored stage counts on startup
    print("Stage counts on startup: ${_stageCountBox.toMap()}");
  }

  static Future<Box<T>> _openBox<T>(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    } else {
      return await Hive.openBox<T>(name);
    }
  }

  static Box<SensorModel> get sensorsBox {
    _checkInit();
    return _sensorsBox;
  }

  /// Add or update a sensor
  static Future<void> saveSensor(SensorModel sensor) async {
    await _sensorsBox.put(sensor.id, sensor);
  }

  /// Remove a sensor
  static Future<void> removeSensor(int id) async {
    await _sensorsBox.delete(id);
  }

  /// Get all sensors
  static List<SensorModel> getAllSensors() {
    return _sensorsBox.values.toList();
  }

  /// Save fetched data from WebSocket
  static Future<void> saveData(List<String> data) async {
    // Convert the List<String> into a List<Map<String, String>>
    List<Map<String, String>> parsedData = data.map((entry) {
      List<String> parts = entry.split(','); // Split the string by comma
      return {
        'sensorId': parts[0],
        'sensorValue': parts[1],
      };
    }).toList();

    await _dataBox.put('websocket_data', parsedData);
    await _dataBox.flush(); // Ensure data is written to storage
  }


  /// Retrieve stored WebSocket data as a List<Map<String, String>>
  static List<Map<String, String>> getData() {
    return _dataBox.get('websocket_data', defaultValue: []) ?? [];
  }


  /// Get the stage count for a particular stage
  static int getStageCount(String stage) {
    try {
      String key = stage.toLowerCase(); // Normalize key format
      if (!_stageCountBox.containsKey(key)) {
        print('Stage "$stage" not found in Hive, returning default 0.');
        return 0;
      }
      final stageCount = _stageCountBox.get(key);
      print('Retrieved stage count for "$stage": ${stageCount?.count ?? 0}');
      return stageCount?.count ?? 0;
    } catch (e) {
      print('Error getting stage count for "$stage": $e');
      return 0;
    }
  }

  /// Update the stage count
  static Future<void> updateStageCount(String stage, {bool increment = true}) async {
    try {
      String key = stage.toLowerCase(); // Ensure consistent key usage
      StageCount? stageCount = _stageCountBox.get(key);

      if (stageCount == null) {
        print('Stage "$stage" not found. Creating new entry.');
        stageCount = StageCount(stage: stage, count: 0);
      }

      // Update the count
      stageCount.count = increment ? stageCount.count + 1 : (stageCount.count > 0 ? stageCount.count - 1 : 0);

      // Save the updated stage count
      await _stageCountBox.put(key, stageCount);
      await _stageCountBox.flush(); // Ensure data is saved
      print('Updated stage "$stage" count: ${stageCount.count}');
    } catch (e) {
      print('Error updating stage count for "$stage": $e');
    }
  }

  /// Save the new WebSocket data with additional columns: Stages, Soil Moisture
  static Future<void> saveWebSocketData(List<String> data) async {
    List<Map<String, String>> parsedData = data.map((entry) {
      List<String> parts = entry.split(',');
      return {
        'date_time': parts[0],
        'sensor_id': parts[1],
        'stages': parts[2],
        'soil_moisture': parts[3],
      };
    }).toList();

    await _dataBox.put('websocket_data', parsedData);
    await _dataBox.flush(); // Ensure data is written to storage
  }

  static void _checkInit() {
    if (!_isInitialized) {
      throw Exception("HiveService.init() must be called before accessing boxes.");
    }
  }
}
