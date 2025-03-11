import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:Aquamansi/routes/defineroutes.dart';
import 'package:Aquamansi/hive/websocket.dart';
import 'package:Aquamansi/hive/hive.dart'; // Import HiveService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await HiveService.init(); // Initialize HiveService

  // Lock orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WebSocketService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final wsService = Provider.of<WebSocketService>(context, listen: false);

      try {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi) {
          wsService.connect();
          debugPrint("WebSocket connected.");
        } else {
          debugPrint("No WiFi connection. WebSocket not started.");
        }
      } catch (e) {
        debugPrint("Error checking connectivity: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey, // Ensure SnackBars can be shown
      debugShowCheckedModeBanner: false,
      title: 'AquaMansi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: defineroutes(),
    );
  }
}
