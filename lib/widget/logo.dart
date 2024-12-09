import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;

  // Constructor with optional parameters for width and height
  const Logo({Key? key, this.width = 200, this.height = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Image.asset('asset/logo1.png', // Corrected the path to match your assets folder
      width: width,
      height: height,
    );
  }
}
