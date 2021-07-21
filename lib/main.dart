import 'package:flutter/material.dart';
import 'package:radio_enlace/src/rutas/rutas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: getAplicationRoutes(),
    );
  }
}
