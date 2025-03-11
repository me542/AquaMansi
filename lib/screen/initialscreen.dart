import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Aquamansi/screen/usermanual.dart';
import 'package:Aquamansi/widget/logo.dart';

void main() => runApp(InitialScreenApp());

class InitialScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(),
      routes: {
        '/manual': (context) => UserManual(), // Route for the user manual
        '/home': (context) => HomeScreen(),  // Your home screen route
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
    _checkFirstLaunch();
  }

  // Function to check if it's the first launch
  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // If it's the first launch, show the user manual and set the flag to false
      prefs.setBool('isFirstLaunch', false);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/manual'); // Navigate to user manual
      });
    } else {
      // If it's not the first launch, navigate to the home screen
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/Home'); // Navigate to home screen
      });
    }
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

// Example HomeScreen widget (replace with your actual home screen)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
