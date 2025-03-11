import 'package:hive/hive.dart';
import 'package:Aquamansi/screen/sensor_model.dart';

class HiveService {
  static bool _isInitialized = false;

  static late Box<SensorModel> _sensorsBox;
  static late Box<int> _executionCountBox;
  static late Box<int> _settingsBox;

  /// Initialize Hive and register adapters
  static Future<void> init() async {
    if (_isInitialized) return;

    Hive.registerAdapter(SensorModelAdapter());

    _sensorsBox = await _openBox<SensorModel>('sensors');
    _executionCountBox = await _openBox<int>('execution_count');
    _settingsBox = await _openBox<int>('settings');

    _isInitialized = true;
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
    await sensor.save(); // Ensures persistence
  }

  /// Remove a sensor
  static Future<void> removeSensor(int id) async {
    await _sensorsBox.delete(id);
  }

  /// Get all sensors
  static List<SensorModel> getAllSensors() {
    return _sensorsBox.values.toList();
  }

  static void _checkInit() {
    if (!_isInitialized) {
      throw Exception("HiveService.init() must be called before accessing boxes.");
    }
  }
}
