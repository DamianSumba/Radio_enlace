import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//import 'package:radio_enlace/src/pages/providers/transforarRad_provider.dart';

class InicioPagina extends StatefulWidget {
  InicioPagina({Key? key}) : super(key: key);

  @override
  _InicioPaginaState createState() => _InicioPaginaState();
}

class _InicioPaginaState extends State<InicioPagina> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        //appBar: AppBar(
        //  title: Text('Inicio'),
        //),
        body: _createBody(context, size));
  }

  SafeArea _createBody(BuildContext context, Size size) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        height: size.height,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            _createHeader(size),
            SizedBox(height: 10),
            _crearBotonUzhoc(context),
            SizedBox(height: 10),
            _crearBotonIngresar(context),
            SizedBox(height: 10),
            _crearBotonSalir(context)
          ],
        ),
      ),
    ));
  }

  _crearBotonUzhoc(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 85, vertical: 10),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.pushNamed(context, 'uzhoc');
        },
        child: Text('Uzhoc'));
  }

  _crearBotonIngresar(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'nodos');
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      child: Text('Ingreso Datos'),
    );
  }

  _crearBotonSalir(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 93, vertical: 10),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onPressed: () {
          SystemNavigator.pop();
        },
        child: Text('Salir'));
  }

  Center _createHeader(Size size) {
    return Center(
      child: Container(
        width: size.width * 0.80,
        height: size.height * 0.50,
        // color: Colors.red,
        child: Image.asset('assets/jadanNet2.jpg'),
      ),
    );
  }
}
