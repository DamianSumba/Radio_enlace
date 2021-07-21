import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:radio_enlace/providers/transforarRad_provider.dart';

class NodosPage extends StatefulWidget {
  NodosPage({Key? key}) : super(key: key);

  @override
  _NodosPageState createState() => _NodosPageState();
}

class _NodosPageState extends State<NodosPage> {
  final myController = TextEditingController();
  int group = 1;
  bool _norte = false;
  bool _sur = false;
  bool _oeste = false;
  bool _este = false;
  bool _clientenorte = false;
  bool _clientesur = false;
  bool _clienteoeste = false;
  bool _clienteeste = false;
  String horasdate = '';

  final horasLatitud = TextEditingController();
  final minutosLatitu = TextEditingController();
  final segundosLatit = TextEditingController();

  final horasLongitud = TextEditingController();
  final minutosLongitud = TextEditingController();
  final segundosLongitud = TextEditingController();

  //Datos Clieentes

  final clienteshorasLatitud = TextEditingController();
  final clientesminutosLatitu = TextEditingController();
  final clientessegundosLatit = TextEditingController();

  final clienteshorasLongitud = TextEditingController();
  final clientesminutosLongitud = TextEditingController();
  final clientessegundosLongitud = TextEditingController();
  final respuestaDistancia = TextEditingController();
  final eleTx = TextEditingController();
  final eleAntx = TextEditingController();
  final eleRx = TextEditingController();
  final eleAntRx = TextEditingController();
  final acimut_Tx = TextEditingController();
  final acimut_Rx = TextEditingController();
  final anguloElev = TextEditingController();
  final frecuencia = TextEditingController();
  final margenEnlace = TextEditingController();

  double? xtx; //latitud
  double? ytx; //longitu
  double? xrx; //latitud cliente
  double? yrx;
  double? d; //distancia
  double? dGr; //distancia
  double? frecuencaData;
  double? lbf;

  //double? elevTx;
  //double? elevAnt;

  double? atr; //acimutTramisor
  double? art; //acimutReceptor

  double? xtxg;
  double? ytxg;
  double? xrxg;
  double? yrxg;

  //variables slider
  double cambiarPotencia = 27;
  double gananciaAntTr = 19;
  double gananciaAntRX = 16;
  double sencilidad = 80;

  //margen elnalce
  double? margenEnl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Nodo'),
      ),
      body: _crearBody(context),
    );
  }

  _crearBody(BuildContext context) {
    //crossAxisAlignment: CrossAxisAlignment.end,

    return Container(
      //margin: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
      margin: const EdgeInsets.all(10.0),

      //color: Colors.amberAccent,
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                'Datos del Nodo',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(),
              Text('LATITUD'),
              Divider(),
              _latitud(),
              Row(
                children: <Widget>[
                  Text('Norte'),
                  Flexible(child: _crearCheckNorte()),
                  Text('Sur'),
                  Flexible(child: _crearCheckSur())
                ],
              ),
              Divider(),
              Text('LONGITUD'),
              Divider(),
              _longitud(),
              Row(
                children: <Widget>[
                  Text('Este'),
                  Flexible(child: _crearChecKEste()),
                  Text('Oeste'),
                  Flexible(child: _crearCheckOeste()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Datos Cliente',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text('LATITUD'),
              Divider(),
              _latitudClinte(),
              Row(
                children: <Widget>[
                  Text('Norte'),
                  Flexible(child: _crearClinteCheckNorte()),
                  Text('Sur'),
                  Flexible(child: _crearClienteCheckSur())
                ],
              ),
              Divider(),
              Text('LONGITUD'),
              Divider(),
              _longitudClinte(),
              Row(
                children: <Widget>[
                  Text('Este'),
                  Flexible(child: _crearClienteChecKEste()),
                  Text('Oeste'),
                  Flexible(child: _crearClienteCheckOeste()),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Elevaciones',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              _elevacionTx(),
              SizedBox(
                height: 10,
              ),
              _elevacionRx(),
              SizedBox(
                height: 20,
              ),
              _frecuencia(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Potencia Antena TX',
                style: TextStyle(fontSize: 20),
              ),
              _sliderPotencia(),
              Text(
                "$cambiarPotencia" '  ' 'dBm',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ganancia Antena TX',
                style: TextStyle(fontSize: 20),
              ),
              _sliderGanciaTx(),
              Text(
                "$gananciaAntTr" '  ' 'dBi',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ganancia Antena RX',
                style: TextStyle(fontSize: 20),
              ),
              _sliderGananciaRx(),
              SizedBox(
                height: 10,
              ),
              Text(
                "$gananciaAntRX" '  ' 'dBi',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' SenciblidadRx ',
                style: TextStyle(fontSize: 15),
              ),
              _sliderSenciblidadRx(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _crearBotonCalcular(context)),
                  SizedBox(
                    width: 50,
                  ),
                  Flexible(child: _crearBotonCancelar(context))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Resultados',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    'Distancia',
                    style: TextStyle(fontSize: 20),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextField(
                      controller: respuestaDistancia,
                    ),
                  ),
                ],
              ),
              _acimuts(),
            ],
          )
        ],
      ),
    );
  }

  Column _sliderPotencia() {
    return Column(
      children: [
        Slider(
            value: cambiarPotencia,
            min: 15,
            max: 35,
            label: "$cambiarPotencia" ' ' 'dBm',
            divisions: 20,
            onChanged: (double valor) {
              setState(() {
                cambiarPotencia = valor;
                print(cambiarPotencia);
              });
            })
      ],
    );
  }

  Column _sliderSenciblidadRx() {
    return Column(
      children: [
        Slider(
            value: sencilidad,
            min: 65,
            max: 100,
            label: "$sencilidad" ' ' 'dBm',
            divisions: 35,
            onChanged: (double valorr) {
              setState(() {
                sencilidad = valorr;
                print(sencilidad);
              });
            })
      ],
    );
  }

  Column _sliderGanciaTx() {
    return Column(
      children: [
        Slider(
            value: gananciaAntTr,
            min: 10,
            max: 25,
            label: "$gananciaAntTr" ' ' 'dBi',
            divisions: 15,
            onChanged: (double valor) {
              setState(() {
                gananciaAntTr = valor;
                print('gananciaAntTr');
                print(gananciaAntTr);
              });
            })
      ],
    );
  }

  Column _sliderGananciaRx() {
    return Column(
      children: [
        Slider(
            value: gananciaAntRX,
            min: 10,
            max: 25,
            label: "$gananciaAntRX" ' ' 'dBi',
            divisions: 15,
            onChanged: (double valor) {
              setState(() {
                gananciaAntRX = valor;
                print('gananciaAntRX');
                print(gananciaAntRX);
              });
            })
      ],
    );
  }

  Row _frecuencia() {
    return Row(
      children: [
        Text(
          'Frecuencia',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: frecuencia,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('GHZ'),
      ],
    );
  }

  Column _acimuts() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'Acimut TX',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                controller: acimut_Tx,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                'Acimut RX',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                controller: acimut_Rx,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                'Elevacion',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                controller: anguloElev,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                'Margen',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: TextField(
                controller: margenEnlace,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Row _elevacionTx() {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Alt TX',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: eleTx,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            'Alt Ant Tx',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: eleAntx,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _elevacionRx() {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Alt RX',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: eleRx,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            'Alt Ant Rx',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: eleAntRx,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _longitud() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00°',
              labelText: 'Horas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: horasLongitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: minutosLongitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Segundos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: segundosLongitud,
          ),
        ),
      ],
    );
  }

  Row _longitudClinte() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00°',
              labelText: 'Horas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clienteshorasLongitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clientesminutosLongitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Segundos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clientessegundosLongitud,
          ),
        ),
      ],
    );
  }

  Row _latitud() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00°',
              labelText: 'Horas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: horasLatitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: minutosLatitu,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Segundos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: segundosLatit,
          ),
        ),
      ],
    );
  }

  Row _latitudClinte() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00°',
              labelText: 'Horas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clienteshorasLatitud,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clientesminutosLatitu,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '00"',
              labelText: 'Segundos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            controller: clientessegundosLatit,
          ),
        ),
      ],
    );
  }

  _crearCheckNorte() {
    return Checkbox(
        value: _norte,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_norte) {
              this._norte = entrda!;
              _sur = false;
            }
          });
        });
  }

  _crearClinteCheckNorte() {
    return Checkbox(
        value: _clientenorte,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_clientenorte) {
              this._clientenorte = entrda!;
              _clientesur = false;
            }
          });
        });
  }

  _crearCheckSur() {
    return Checkbox(
        value: _sur,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_sur) {
              this._sur = entrda!;
              _norte = false;
            }
          });
        });
  }

  _crearClienteCheckSur() {
    return Checkbox(
        value: _clientesur,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_clientesur) {
              this._clientesur = entrda!;
              _clientenorte = false;
            }
          });
        });
  }

  _crearChecKEste() {
    return Checkbox(
        value: _este,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_este) {
              this._este = entrda!;
              _oeste = false;
            }
          });
        });
  }

  _crearClienteChecKEste() {
    return Checkbox(
        value: _clienteeste,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_clienteeste) {
              this._clienteeste = entrda!;
              _clienteoeste = false;
            }
          });
        });
  }

  _crearCheckOeste() {
    return Checkbox(
        value: _oeste,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_oeste) {
              this._oeste = entrda!;
              _este = false;
            }
          });
        });
  }

  _crearClienteCheckOeste() {
    return Checkbox(
        value: _clienteoeste,
        onChanged: (bool? entrda) {
          setState(() {
            if (!_clienteoeste) {
              this._clienteoeste = entrda!;
              _clienteeste = false;
            }
          });
        });
  }

  _crearBotonCalcular(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          calcularDatos();
        },
        child: Text('Calcular'));
  }

  _crearBotonCancelar(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: calcularDatos());
              }); //Navigator.pushNamed(context, 'inicio');
        },
        child: Text('Cancelar'));
  }

  calcularDatos() {
    setState(() {
      print(clienteshorasLatitud.text);
      print(clientesminutosLatitu.text);
      print(clientessegundosLatit.text);

      print(clienteshorasLongitud.text);
      print(clientesminutosLongitud.text);
      print(clientessegundosLongitud.text);

      calculosLatutud();
      _calculosLongitud();
      _calculosLatutudCliente();
      _calculosLongitudCliente();
      _calculoDistancia();
      _calcularAcimut();
      _elevacionNodo();
      _calculoPerdidaLbf();
      _calculoRx();
    });
  }

  calculosLatutud() {
    xtx = double.parse(horasLatitud.text) +
        (double.parse(minutosLatitu.text) / 60) +
        (double.parse(segundosLatit.text) / 3600);

    //cambio signo n/s xtxg
    print(xtx);
    xtxg = xtx;
    if (_norte == true) {
      xtxg = xtxg!;
    } else {
      xtxg = xtxg! * (-1);
    }

    print('hhhhhhhh latud');
    print(xtxg);

    if (_norte == true) {
      xtx = (xtx! * (pi)) / 180;
    } else {
      xtx = (xtx! * (-pi)) / 180;
    }
    //double totalLt = horasLt + minutosLt;
    //sur, este negativos
    print('latitud');
    print('--------------');

    print(xtx);
  }

  _calculosLongitud() {
    ytx = double.parse(horasLongitud.text) +
        (double.parse(minutosLongitud.text) / 60) +
        (double.parse(segundosLongitud.text) / 3600);

    ytxg = ytx;

    if (_este == true) {
      ytxg = ytxg!;
    } else {
      ytxg = ytxg! * (-1);
    }

    print('hhhhhhhh longitud');
    print(ytxg);

    if (_este == true) {
      ytx = (ytx! * (pi)) / 180;
    } else {
      ytx = (ytx! * (-pi)) / 180;
    }
    print('longitud');
    print(ytx);
  }

  _calculosLatutudCliente() {
    xrx = double.parse(clienteshorasLatitud.text) +
        (double.parse(clientesminutosLatitu.text) / 60) +
        (double.parse(clientessegundosLatit.text) / 3600);

    xrxg = xrx;
    if (_clientenorte == true) {
      xrxg = xrxg!;
    } else {
      xrxg = xrxg! * (-1);
    }
    print('hhhhhhhh latudu cñliente');
    print(xrxg);

    if (_clientenorte == true) {
      xrx = (xrx! * (pi)) / 180;
    } else {
      xrx = (xrx! * (-pi)) / 180;
    }
    //double totalLt = horasLt + minutosLt;
    //sur, este negativos
    print('latitud Cliente');
    print(xrx);
  }

  _calculosLongitudCliente() {
    yrx = double.parse(clienteshorasLongitud.text) +
        (double.parse(clientesminutosLongitud.text) / 60) +
        (double.parse(clientessegundosLongitud.text) / 3600);

    yrxg = yrx;
    if (_clienteeste == true) {
      yrxg = yrxg!;
    } else {
      yrxg = yrxg! * (-1);
    }
    print('hhhhhhhh longitud cliente');
    print(yrxg);
    if (_clienteeste == true) {
      yrx = (yrx! * (pi)) / 180;
    } else {
      yrx = (yrx! * (-pi)) / 180;
    }
    print('longitud Cliente');
    print(yrx);
  }

  _calculoDistancia() {
    d = 6378 *
        acos(
            sin(xtx!) * sin(xrx!) + (cos(xtx!) * cos(xrx!)) * cos(yrx! - ytx!));

    print('------distancia--------');
    print(d);

    respuestaDistancia.text = d.toString() + ' ' + 'km';

    dGr = d! / 111.18;

    print('*****************');
    dGr = dGr! * pi / 180;

    print('distancia grados.......');
    print(dGr);
  }

  _calcularAcimut() {
    // acimut trasmisor-receptor

    print('distacia original');

    print(d);
    double distancia = d!;

    print('distacia cambia');
    print(distancia);

    distancia = distancia / 111.18;
    print('distacia cambia 2');
    print(distancia);

    atr = acos((sin(xrxg!) - cos(distancia) * sin(xtxg!)) /
        (sin(distancia) * cos(xtxg!)));

    print('atr radianes');
    print('xtxg');
    print(xtxg);
    print('xrxg');
    print(xrxg);

    print('atr******');

    print(atr);
    atr = atr! * 180 / pi;
    print('acimut atr');
    print(atr);

    //acimut receptor-trasmisor
    art = acos((sin(xtxg!) - cos(distancia) * sin(xrxg!)) /
        (sin(distancia) * cos(xrxg!)));
    art = art! * 180 / pi;
    print('acimut art');
    print(art);

    //double atrFinal = art!;
    //double artFinal = atr!;

    print('Prueba Variables Finales');
    print('atrFinal');
    print(atr);
    print('artFinal');
    print(art);

    double validacion = (yrxg! - ytxg!);
    print('pruebaaaa');
    print(validacion);
    if (validacion > 0) {
      atr = atr;
      art = 360 - art!;
    } else {
      atr = 360 - atr!;
      art = art;
    }

    print('--------------------');
    print('atrFinal');
    print(atr);

    print('artFinal');
    print(art);

    acimut_Tx.text = atr.toString() + '' + '°';
    acimut_Rx.text = art.toString() + '' + '°';

//------------------------------------------------------------------------------

/**
  double deltaLong = xtxg! - xrxg!;
    print('deltaLong');
    print(deltaLong);

    double deltaLat = ytxg! - yrxg!;
    print('deltaLat');
    print(deltaLat);

//calculo acimut receptor
    double teta = atan(deltaLong / deltaLat);
    print('teta');
    print(teta);
    teta = teta * 180 / pi;
    double c = 90;
    double acimutRx = c + teta.abs();
    print('acimut Rx *********');
    print(acimutRx);
    acimut_Rx.text = acimutRx.toString() + '°';

//calulo acimut trasmisor

    double acimutTx = 270 + teta.abs();
    print('acimut Tx *****');
    print(acimutTx);
    acimut_Tx.text = acimutTx.toString() + '°';
 */
  }

  _elevacionNodo() {
    //eleTx.text = eleTx.toString();
    //eleAnt.text = eleAnt.toString();

    int h1 = int.parse(eleTx.text) + int.parse(eleAntx.text);
    int h2 = int.parse(eleRx.text) + int.parse(eleAntRx.text);

    int deltAltura = h1 - h2;
    print('deltaAltura');
    print(deltAltura);
    print(d);

    //calculo angulo elevacion
    double alpha = asin((deltAltura / 1000) / d!);

    alpha = (alpha * 180) / pi;

    print('angulos elevacion');
    print(alpha);

    anguloElev.text = alpha.toString() + '°';
  }

  _calculoPerdidaLbf() {
    frecuencaData = double.parse(frecuencia.text);
    print('frecuencai');

    frecuencaData = frecuencaData! * 1000;
    print('frecuencai calcu');
    print(frecuencaData);
    print('dist km');
    print(d);

    lbf = 32.4 +
        (20 * (log(frecuencaData!)) / log(10)) +
        ((20 * log(d!) / log(10)));
    print('----------perdida ----------');
    print(lbf);
  }

//calculo Potencia recibida
  _calculoRx() {
    int atenuacionCable = 3;

    //calculo potencia recibida receptor

    double prx = cambiarPotencia -
        atenuacionCable +
        gananciaAntTr -
        lbf! +
        gananciaAntRX -
        atenuacionCable;

    print('prx');

    print(prx);

//calculo potencia isotropica radiada efectica

    double pire = cambiarPotencia - atenuacionCable + gananciaAntTr;
    print('pire');

    print(pire);

    //calcular margen de enlace
    margenEnl = prx - (-sencilidad);

    margenEnlace.text = margenEnl.toString() + ' ' + 'dB';

    print('margenEnl');

    print(margenEnl);
  }
}
