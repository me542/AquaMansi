import 'package:aquamansi_frontend/screen/menuoption.dart';
import 'package:aquamansi_frontend/screen/usermanual.dart';
import 'package:aquamansi_frontend/widget/logo.dart';
import 'package:flutter/material.dart';

void main() => runApp(InitialScreenApp());

class InitialScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(),
      routes: {
        '/manual': (context) => UserManual(), // Define the next route properly
      },
    );
  }
}

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and navigate to the next screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/manual'); // Navigate to Menu()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Logo(
          width: 100, // Adjust size as needed
          height: 100,
        ),
      ),
    );
  }
}
