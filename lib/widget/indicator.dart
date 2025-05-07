import 'package:flutter/material.dart';
import 'package:Aquamansi/service/notif.dart';
import 'package:Aquamansi/hive/websocket.dart';


class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}


class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator>
    with SingleTickerProviderStateMixin {
  bool isActivated = false;
  final WebSocketService _webSocketService = WebSocketService();
  AnimationController? _controller;


  @override
  void initState() {
    super.initState();
    NotificationsService.init();
    _webSocketService.connect();
    _webSocketService.onMessage(_onWebSocketMessage);


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {}); // Rebuild to update rotation
    });
    _controller?.repeat();
    _controller?.stop(); // Don't rotate by default
  }


  void _onWebSocketMessage(String message) {
    // Handle incoming messages if needed
  }


  void handleButtonClick() async {
    setState(() {
      isActivated = !isActivated;
    });


    if (isActivated) {
      _controller?.repeat(); // Start spinning
      _webSocketService.sendMessage("R");
      await NotificationsService.showStartNotification();
    } else {
      _controller?.stop(); // Stop spinning
      _webSocketService.sendMessage("S"); // Optional: send stop signal
      await NotificationsService.showDoneNotification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Irrigation process is deactivated.')),
      );
    }
  }


  @override
  void dispose() {
    _webSocketService.disconnect();
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        GestureDetector(
          onTap: handleButtonClick,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Transform.rotate(
                  angle: isActivated ? _controller!.value * 6.3 : 0,
                  child: CircularProgressIndicator(
                    value: isActivated ? null : 0,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CECAE)),
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.transparent, width: 4),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'asset/icon3.png',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          isActivated ? 'Running' : 'Ready',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF27B5D9),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: handleButtonClick,
          child: Text(
            isActivated ? 'Deactivate' : 'Activate',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: isActivated ? Colors.red : Color(0xFF27B5D9),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
