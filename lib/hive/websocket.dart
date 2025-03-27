import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;
  final StreamController<String> _streamController = StreamController.broadcast();

  Stream<String> get messages => _streamController.stream;

  void connect() {
    String ssid = "Aquamansi-AP";
    String ipAddress = "192.168.4.1";
    String url = "ws://$ipAddress/ws"; // Corrected WebSocket URL

    try {
      _channel = IOWebSocketChannel.connect(url);
      _channel.stream.listen(
            (message) {
          _streamController.add(message);
          print("Received: $message");
        },
        onDone: () => print("WebSocket closed"),
        onError: (error) {
          print("WebSocket error: $error");
          _reconnect(); // Attempt reconnect
        },
      );
      print("Connected to SSID: $ssid, IP: $ipAddress");
    } catch (e) {
      print("Connection failed: $e");
      _reconnect();
    }
  }

  void sendMessage(String message) {
    try {
      _channel.sink.add(message); // Send plain text instead of JSON
      print("Sent: $message");
    } catch (e) {
      print("Send failed: $e");
    }
  }

  void _reconnect() {
    Future.delayed(Duration(seconds: 5), connect); // Retry after 5 seconds
  }

  void disconnect() {
    _channel.sink.close();
    _streamController.close();
    print("WebSocket disconnected");
  }
}
