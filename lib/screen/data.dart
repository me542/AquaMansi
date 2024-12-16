import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/appbar.dart'; // Adjust this import path

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,  // Back arrow visible
        showMenuButton: false,  // No menu button on Data screen
      ),
      body: Center(
        child: Text('Your Body Content Here'),
      ),
    );
  }
}
