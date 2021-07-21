import 'package:flutter/material.dart';
import 'dart:math';

class OperacionesMate {
  //datos longitud
  final controlerhorasLongitud = TextEditingController();
  final controlerminutosLongitud = TextEditingController();
  final controlersegundosLongitud = TextEditingController();

  //datos latitud

  final controlehorasLatitud = TextEditingController();
  final controlerminutosLatitud = TextEditingController();
  final controlersegundosLatitud = TextEditingController();

  double? horasLongitud;
  double? minutosLongit;
  double? segundosLongi;

  void TransformarLatitud() {
    double horasLatitud = double.parse(controlehorasLatitud.text);
    double? minutosLatitud = double.parse(controlerminutosLatitud.text);
    double? segundosLatitud = double.parse(controlersegundosLatitud.text);

    //calculos

    minutosLatitud = minutosLatitud / 60;
    segundosLatitud = segundosLatitud / 3600;

    print(horasLatitud);

    double totalLatitud = horasLatitud + minutosLatitud + segundosLatitud;
    print(totalLatitud);
  }
}
