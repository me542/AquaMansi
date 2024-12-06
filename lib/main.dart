import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/routes/defineroutes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'AquaMansi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Initial route
      routes: defineroutes(), // Use the function to define routes
    );
  }
}





