import 'package:flutter/material.dart';
import 'package:radio_enlace/src/pages/inicio_page.dart';
import 'package:radio_enlace/src/pages/nodos_page.dart';
import 'package:radio_enlace/src/pages/uzhoc.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'inicio': (BuildContext contex) => InicioPagina(),
    'nodos': (BuildContext contex) => NodosPage(),
    'uzhoc': (BuildContext contex) => UzhocPage(),
  };
}
