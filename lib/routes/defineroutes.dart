  import 'package:Aquamansi/screen/initialscreen.dart';
  import 'package:Aquamansi/screen/menuoption.dart';
  import 'package:flutter/material.dart';
  import '../screen/homescreen.dart';
  import '../screen/usermanual.dart';
  // Add more imports as needed

  Map<String, WidgetBuilder> defineroutes() {
    return {
      '/': (context) => InitialScreen(),
      '/manual': (context) => UserManual(),
      '/1': (context) => Menu(),
      '/Home': (context) => Homescreen(),
      '/menu': (context) => const Menu(),

    };
  }
