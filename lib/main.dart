import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/routes/defineroutes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaMansi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // Default text color
        ),
      ),
      initialRoute: '/',
      routes: defineroutes(),
    );
  }
}
