import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:radio_enlace/providers/transforarRad_provider.dart';

class UzhocPage extends StatefulWidget {
  UzhocPage({Key? key}) : super(key: key);

  @override
  _UzhocPageState createState() => _UzhocPageState();
}

class _UzhocPageState extends State<UzhocPage> {
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

  double? horaslatitudkte;
  double? minutoslatitudkte;
  double? segudoslatitudkte;
  double? horaslongitudkte;
  double? minutoslongitudkte;
  double? segundoslongitudkte;

  final clienteshorasLatitud = TextEditingController();
  final clientesminutosLatitu = TextEditingController();
  final clientessegundosLatit = TextEditingController();

  final clienteshorasLongitud = TextEditingController();
  final clientesminutosLongitud = TextEditingController();
  final clientessegundosLongitud = TextEditingController();
  final respuestaDistancia = TextEditingController();
  final _eleTx = TextEditingController();
  final _eleAntx = TextEditingController();
  final _eleRx = TextEditingController();
  final _eleAntRx = TextEditingController();
  final _acimut_Tx = TextEditingController();
  final _acimut_Rx = TextEditingController();
  final _anguloElev = TextEditingController();

  final altTx = TextEditingController();
  final altTxAnt = TextEditingController();
  final altRx = TextEditingController();
  final altrxAnt = TextEditingController();

  double? xtx; //latitud
  double? ytx; //longitu
  double? xrx; //latitud cliente
  double? yrx;
  double? d; //distancia
  double? dGr; //distancia

  double? elevTx;
  double? elevAnt;

  int? altTxKte;
  int? altTxAntKte;
  double? altRxKte;
  double? altrxAntKte;

  double? atr; //acimutTramisor
  double? art; //acimutReceptor

  double? xtxg;
  double? ytxg;
  double? xrxg;
  double? yrxg;

  @override
  Widget build(BuildContext context) {
    _calculosLatutud();
    _calculosLongitud();

    altTxKte = 2985;
    altTxAntKte = 20;

    altTx.text = altTxKte.toString();
    altTxAnt.text = altTxAntKte.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Nodo Uzhoc'),
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
              Divider(),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  //Text('Norte'),
                  //Flexible(child: _crearCheckNorte()),
                  Text('Sur'),
                  //Flexible(child: _crearCheckSur())
                ],
              ),
              Divider(),
              Text('LONGITUD'),
              Divider(),
              _longitud(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  //Text('Este'),
                  // Flexible(child: _crearChecKEste()),
                  Text('Oeste'),
                  // Flexible(child: _crearCheckOeste()),
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
              _elevacionTx(),
              SizedBox(
                height: 20,
              ),
              _elevacionRx(),
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
                  //Flexible(child: Text('km'))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _acimuts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _crearBotonGuardar(context)),
                  SizedBox(
                    width: 50,
                  ),
                  Flexible(child: _crearBotonCancelar(context))
                ],
              ),
            ],
          )
        ],
      ),
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
            controller: altTx,
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
            controller: altTxAnt,
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
            controller: _eleRx,
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
            controller: _eleAntRx,
            keyboardType: TextInputType.number,
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
                controller: _acimut_Tx,
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
                controller: _acimut_Rx,
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
                controller: _anguloElev,
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

  _crearCheckNorte() {
    return Checkbox(
        value: _norte,
        onChanged: (bool? entrda) {
          setState(() {
            if (_norte) {
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
            if (_este) {
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
          entrda = true;
          setState(() {
            //if (!_oeste) {
            //  this._oeste = entrda!;
            //  _este = false;
            this._oeste = entrda!;
            // }
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

  _crearBotonGuardar(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          calcularDatos();
        },
        child: Text('Calcular'));
  }

  _crearBotonCancelar(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'inicio');
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

      _calculosLatutud();
      _calculosLongitud();
      _calculosLatutudCliente();
      _calculosLongitudCliente();
      _calculoDistancia();
      _calcularAcimut();
      _elevacionNodo();
    });
  }

  _calculosLatutud() {
    //final horasLatitud = TextEditingController();
    //final minutosLatitu = TextEditingController();
    //final segundosLatit = TextEditingController();
//
    //final horasLongitud = TextEditingController();
    //final minutosLongitud = TextEditingController();
    //final segundosLongitud = TextEditingController();

    horaslatitudkte = 2;
    minutoslatitudkte = 54;
    segudoslatitudkte = 6.34;

    horasLatitud.text = horaslatitudkte.toString();
    minutosLatitu.text = minutoslatitudkte.toString();
    segundosLatit.text = segudoslatitudkte.toString();

    xtx = horaslatitudkte! +
        (minutoslatitudkte! / 60) +
        (segudoslatitudkte! / 3600);

    print(xtx);

    xtxg = xtx;

    if (_norte == true) {
      xtxg = xtxg!;
    } else {
      xtxg = xtxg! * (-1);
    }
    print('hhhhhhhh latud');
    print(xtxg);

    //if (_norte == true) {
    //  xtx = (xtx! * (pi)) / 180;
    //} else {
    xtx = (xtx! * (-pi)) / 180;
    //}
    //double totalLt = horasLt + minutosLt;
    //sur, este negativos
    print('latitud');
    print('--------------');

    print(xtx);
  }

  _calculosLongitud() {
    horaslongitudkte = 78;
    minutoslongitudkte = 52;
    segundoslongitudkte = 14.83;

    horasLongitud.text = horaslongitudkte.toString();
    minutosLongitud.text = minutoslongitudkte.toString();
    segundosLongitud.text = segundoslongitudkte.toString();

    ytx = horaslongitudkte! +
        (minutoslongitudkte! / 60) +
        (segundoslongitudkte! / 3600);

    ytxg = ytx;

    if (_este == true) {
      ytxg = ytxg!;
    } else {
      ytxg = ytxg! * (-1);
    }
    print('hhhhhhhh longitud');
    print(ytxg);

    //if (_este == true) {
    //  ytx = (ytx! * (pi)) / 180;
    //} else {
    //  ytx = (ytx! * (-pi)) / 180;
    //}
    ytx = (ytx! * (-pi)) / 180;
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

    respuestaDistancia.text = d.toString();

    dGr = d! / 111.18;

    print('*****************');
    dGr = dGr! * pi / 180;

    print('distancia grados.......');
    print(dGr);
  }

  _elevacionNodo() {
    //eleTx.text = eleTx.toString();
    //eleAnt.text = eleAnt.toString();

    altTxKte = 2985;
    altTxAntKte = 20;

    altTx.text = altTxKte.toString();
    altTxAnt.text = altTxAntKte.toString();

    int h1 = altTxKte! + altTxAntKte!;
    int h2 = int.parse(_eleRx.text) + int.parse(_eleAntRx.text);

    int deltAltura = h1 - h2;
    print('deltaAltura');
    print(deltAltura);
    print(d);

    //calculo angulo elevacion
    double alpha = asin((deltAltura / 1000) / d!);

    alpha = (alpha * 180) / pi;

    print('angulos elevacion');
    print(alpha);

    _anguloElev.text = alpha.toString() + '°';
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

    _acimut_Tx.text = atr.toString() + '' + '°';
    _acimut_Rx.text = art.toString() + '' + '°';

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
}
