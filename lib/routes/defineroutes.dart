import 'package:aquamansi_frontend/screen/initialscreen.dart';
import 'package:aquamansi_frontend/screen/menuoption.dart';
import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/appbar.dart';
import '../screen/homescreen.dart';
import '../screen/usermanual.dart';


// Add more imports as needed

Map<String, WidgetBuilder> defineroutes() {
  return {
    '/': (context) => InitialScreen(),
    '/Appbar': (context) => AppBar(),
    '/manual': (context) => UserManual(),
    '/1': (context) => Menu(),
    '/Home': (context) => Homescreen(),

  };
}
