import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<String> _streamController = StreamController.broadcast();
  bool isConnected = false; // Track connection status

  Stream<String> get messages => _streamController.stream;

  void connect() {
    String ipAddress = "192.168.4.1";
    String url = "ws://$ipAddress/ws";

    try {
      _channel = IOWebSocketChannel.connect(url);
      isConnected = true; // Set connected status
      _channel?.stream.listen(
            (message) {
          _streamController.add(message);
          print("Received: $message");

          // If the message is numeric, update the connection status
          if (int.tryParse(message) != null) {
            print("Number of connected clients: $message");
          }
        },
        onDone: () {
          print("WebSocket closed");
          isConnected = false;
          _reconnect();
        },
        onError: (error) {
          print("WebSocket error: $error");
          isConnected = false;
          _reconnect();
        },
      );
      print("Connected to WebSocket at: $ipAddress");
    } catch (e) {
      print("Connection failed: $e");
      isConnected = false;
      _reconnect();
    }
  }

  void sendMessage(String message) {
    if (isConnected) {
      try {
        _channel?.sink.add(message);
        print("Sent: $message");
      } catch (e) {
        print("Send failed: $e");
      }
    } else {
      print("Cannot send message, WebSocket not connected.");
    }
  }

  void fetchData() {
    sendMessage("FETCH_DATA");
  }

  void checkConnection() {
    sendMessage("CHECK_CONNECTION");
  }

  void _reconnect() {
    if (!isConnected) {
      Future.delayed(Duration(seconds: 5), connect); // Retry after 5 seconds
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _streamController.close();
    print("WebSocket disconnected");
  }

  void onMessage(Function(String) callback) {
    _streamController.stream.listen(callback);
  }
}