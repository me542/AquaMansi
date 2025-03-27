// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:Aquamansi/main.dart'; // Import main.dart for scaffoldMessengerKey
//
// class WebSocketService extends ChangeNotifier {
//   WebSocketChannel? _channel;
//   int? irrigationInterval;
//   bool isConnected = false;
//   Timer? _pingTimer;
//   Timer? _reconnectTimer;
//   int _reconnectAttempts = 0;
//
//   WebSocketService();
//
//   Future<void> connect() async {
//     if (isConnected) return;
//
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult != ConnectivityResult.wifi) {
//       setDisconnectedState();
//       _scheduleReconnect();
//       return;
//     }
//
//     try {
//       _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.4.1:81'));
//       _setConnectedState();
//
//       _channel!.stream.listen(
//             (message) => _handleMessage(message),
//         onDone: () {
//           setDisconnectedState();
//           _scheduleReconnect();
//         },
//         onError: (error) {
//           setDisconnectedState();
//           _scheduleReconnect();
//         },
//       );
//
//       _startPing(); // Start sending periodic pings
//     } catch (e) {
//       setDisconnectedState();
//       _scheduleReconnect();
//     }
//   }
//
//   void _scheduleReconnect() {
//     if (isConnected) return;
//
//     _reconnectAttempts++;
//     int delay = (_reconnectAttempts < 5) ? 2 : 5; // Increase delay after multiple failures
//
//     _reconnectTimer?.cancel();
//     _reconnectTimer = Timer(Duration(seconds: delay), connect);
//   }
//
//   void _handleMessage(String message) {
//     if (message.startsWith('{')) {
//       try {
//         final data = jsonDecode(message);
//         irrigationInterval = data['irrigation_interval'];
//         notifyListeners();
//         _setConnectedState();
//       } catch (e) {
//         debugPrint("Error decoding message: $e");
//       }
//     }
//   }
//
//   void _setConnectedState() {
//     if (!isConnected) {
//       isConnected = true;
//       _reconnectAttempts = 0;
//       notifyListeners();
//       _removeDisconnectSnackBar();
//       _showSnackBar("Connected to ESP8266", Colors.green, const Duration(seconds: 2));
//     }
//   }
//
//   void setDisconnectedState() {
//     if (isConnected) {
//       isConnected = false;
//       _showDisconnectSnackBar();
//       _stopPing(); // Stop sending pings when disconnected
//     }
//   }
//
//   void _showSnackBar(String message, Color color, Duration duration) {
//     MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         duration: duration,
//       ),
//     );
//   }
//
//   void _showDisconnectSnackBar() {
//     MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: const Text("Disconnected. Reconnecting..."),
//         backgroundColor: Colors.red,
//         duration: const Duration(days: 1),
//         action: SnackBarAction(
//           label: 'Dismiss',
//           onPressed: () {
//             MyApp.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//           },
//         ),
//       ),
//     );
//   }
//
//   void _removeDisconnectSnackBar() {
//     MyApp.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//   }
//
//   void sendMessage(String message) {
//     if (isConnected) {
//       _channel?.sink.add(message);
//     }
//   }
//
//   void _startPing() {
//     _pingTimer?.cancel();
//     _pingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
//       if (isConnected) {
//         _channel?.sink.add("ping");
//       }
//     });
//   }
//
//   void _stopPing() {
//     _pingTimer?.cancel();
//   }
//
//   void disconnect() {
//     _channel?.sink.close(status.goingAway);
//     setDisconnectedState();
//     _stopPing();
//   }
//
//   bool get isConnectedStatus => isConnected;
// }
