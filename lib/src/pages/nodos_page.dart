import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
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

  final _eleTx = TextEditingController();
  final _eleAntx = TextEditingController();
  final _eleRx = TextEditingController();
  final _eleAntRx = TextEditingController();
  final _acimut_Tx = TextEditingController();
  final _acimut_Rx = TextEditingController();
  final _anguloElev = TextEditingController();

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

  double? xtx1;
  double? ytx1;

  //variables slider
  double cambiarPotencia = 27;
  double gananciaAntTr = 19;
  double gananciaAntRX = 16;
  double sencilidad = 80;

  //
  double? elevTx;
  double? elevAnt;

  double? altTxKte;
  double? altTxAntKte;
  double? altRxKte;
  double? altrxAntKte;

  double? horaslatitudkte;
  double? minutoslatitudkte;
  double? segudoslatitudkte;
  double? horaslongitudkte;
  double? minutoslongitudkte;
  double? segundoslongitudkte;

  final altTx = TextEditingController();
  final altTxAnt = TextEditingController();
  final altRx = TextEditingController();
  final altrxAnt = TextEditingController();

  //margen elnalce
  double? margenEnl;

  //variable obtener ubicacion
  var location = new Location();
  LocationData? userLocation;
  LocationData? _currentLocation;
  String _longData = '';
  String _latData = '';
  String _altitudData = '';

  final ubilatituCli = TextEditingController();
  final ubilongitudCli = TextEditingController();
  final ubialtudCli = TextEditingController();

  //variales dropItem selección
  String? _valorSelecionado = 'selecione Nodo';

  List _nodosList = [
    'selecione Nodo',
    'Oficina ISP',
    'Nodo Chocarsi',
    'Nodo Uzhoc'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso Datos'),
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
              _crearDrowButton(),
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
                height: 30,
              ),
              _ubicacion(),
              SizedBox(
                height: 20,
                // ),
                // Text('LATITUD'),
                // Divider(),
                // _latitudClinte(),
                // Row(
                //   children: <Widget>[
                //     Text('Norte'),
                //     Flexible(child: _crearClinteCheckNorte()),
                //     Text('Sur'),
                //     Flexible(child: _crearClienteCheckSur())
                //   ],
                // ),
                // Divider(),
                // Text('LONGITUD'),
                // Divider(),
                // _longitudClinte(),
                // Row(
                //   children: <Widget>[
                //     Text('Este'),
                //     Flexible(child: _crearClienteChecKEste()),
                //     Text('Oeste'),
                //     Flexible(child: _crearClienteCheckOeste()),
                // ],
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

  List<DropdownMenuItem<String>>? getOpcionesNodos() {
    List<DropdownMenuItem<String>> lista = new List.of([]);
    _nodosList.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  Widget _crearDrowButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Selecionar Nodo',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: 175,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.blueAccent, width: 2)),
            child: DropdownButton(
              style: TextStyle(fontSize: 15, color: Colors.black),
              icon: Icon(
                Icons.list_alt_sharp,
                color: Colors.blueAccent,
                size: 30,
              ),
              dropdownColor: Colors.blue[300],
              value: _valorSelecionado,
              items: getOpcionesNodos(),
              onChanged: (String? opt) {
                setState(() {
                  _valorSelecionado = opt;

                  if (opt == 'Nodo Uzhoc') {
                    print('holaaaa iff');
                    calculosLatutud();
                    _calculosLongitud();
                    altTxKte = 2985;
                    altTxAntKte = 20;
                    altTx.text = altTxKte.toString();
                    altTxAnt.text = altTxAntKte.toString();
                  } else {
                    if (opt == 'Nodo Chocarsi') {
                      print('holaaaa central');
                      _calculosLatutudNodoChocarsi();
                      _calculosLongitudNodoChocarsi();
                      altTxKte = 2751;
                      altTxAntKte = 20;
                      altTx.text = altTxKte.toString();
                      altTxAnt.text = altTxAntKte.toString();
                    } else {
                      _calculosLatutudNodoOficina();
                      _calculosLongitudNodoOficina();
                      altTxKte = 2690;
                      altTxAntKte = 20;
                      altTx.text = altTxKte.toString();
                      altTxAnt.text = altTxAntKte.toString();
                    }
                  }
                });
              },
            ),
          ),
        ),
      ],
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
            keyboardType: TextInputType.number,
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
          Navigator.pushNamed(context, 'inicio');
          //Navigator.pushNamed(context, 'inicio');
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
      // _calculosLatutudCliente();
      //_calculosLongitudCliente();
      //_calculoDistancia();
      _calculoDistanciaUbi();
      _calcularAcimut();
      _elevacionNodo();
      _calculoPerdidaLbf();
      _calculoRx();
    });
  }

  calculosLatutud() {
    horaslatitudkte = 2;
    minutoslatitudkte = 54;
    segudoslatitudkte = 6.34;

    horasLatitud.text = horaslatitudkte.toString();
    minutosLatitu.text = minutoslatitudkte.toString();
    segundosLatit.text = segudoslatitudkte.toString();

    xtx = horaslatitudkte! +
        (minutoslatitudkte! / 60) +
        (segudoslatitudkte! / 3600);

    //print(xtx1);
    print('00000000000');
    print(xtx);

    xtxg = xtx! * pi / 180;

    if (_norte == true) {
      xtxg = xtxg!;
      xtx1 = xtx;
    } else {
      xtxg = xtxg! * (-1);
      xtx1 = xtx! * (-1);
    }
    print('hhhhhhhh latud');
    print(xtxg);
//
    ////if (_norte == true) {
    ////  xtx = (xtx! * (pi)) / 180;
    ////} else {
    //xtx = (xtx! * (-pi)) / 180;
    ////}
    ////double totalLt = horasLt + minutosLt;
    ////sur, este negativos
    print('latitud');
    print('--------------');

    print(xtx);
    //xtx = double.parse(horasLatitud.text) +
    //    (double.parse(minutosLatitu.text) / 60) +
    //    (double.parse(segundosLatit.text) / 3600);
//
    ////cambio signo n/s xtxg
    //print(xtx);
    //xtxg = xtx;
    //if (_norte == true) {
    //  xtxg = xtxg!;
    //} else {
    //  xtxg = xtxg! * (-1);
    //}
//
    //print('hhhhhhhh latud');
    //print(xtxg);
//
    //if (_norte == true) {
    //  xtx = (xtx! * (pi)) / 180;
    //} else {
    //  xtx = (xtx! * (-pi)) / 180;
    //}
    ////double totalLt = horasLt + minutosLt;
    ////sur, este negativos
    //print('latitud');
    //print('--------------');
//
    //print(xtx);
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

    ytxg = ytx! * pi / 180;
    print('!!!!!!!!!!!!!!!!!!!!');

    if (_este == true) {
      ytxg = ytxg!;
      ytx1 = ytx;
    } else {
      ytxg = ytxg! * (-1);
      ytx1 = ytx! * (-1);
    }
    print('hhhhhhhh longitud');
    print(ytxg);

    print('999999999999');
//
    print(xtxg);
    print(ytxg);
    ////if (_este == true) {
    ////  ytx = (ytx! * (pi)) / 180;
    ////} else {
    ////  ytx = (ytx! * (-pi)) / 180;
    ////}
    //ytx = (ytx! * (-pi)) / 180;
    //print('longitud');
    //print(ytx);
    //ytx = double.parse(horasLongitud.text) +
    //    (double.parse(minutosLongitud.text) / 60) +
    //    (double.parse(segundosLongitud.text) / 3600);
//
    //ytxg = ytx;
//
    //if (_este == true) {
    //  ytxg = ytxg!;
    //} else {
    //  ytxg = ytxg! * (-1);
    //}
//
    //print('hhhhhhhh longitud');
    //print(ytxg);
//
    //if (_este == true) {
    //  ytx = (ytx! * (pi)) / 180;
    //} else {
    //  ytx = (ytx! * (-pi)) / 180;
    //}
    //print('longitud');
    //print(ytx);
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

  _calculoDistanciaUbi() {
    print('##################33');
    xrxg = double.parse(_latData);

    xrx = (xrxg! * pi) / 180;
    print(_latData);
    print(xrx);
    yrxg = double.parse(_longData);
    print('long)');
    print(yrxg);
    yrx = yrxg! * pi / 180;
    //print(_longData);
    print(yrx);
//
    print('valores nodo');
    print(xtxg);
    print(ytxg);
    print('vvvvvvvvvvvvvvvvvvvvvv');
    print(xrx);
    print(yrx);

    d = 6378 *
        acos(sin(xtxg!) * sin(xrx!) +
            (cos(xtxg!) * cos(xrx!)) * cos(yrx! - ytxg!));

    print('------distancia--------');
    print(d);

    respuestaDistancia.text = d.toString() + ' ' + 'km';

    dGr = d! / 111.18;

    print('*****************');
    dGr = dGr! * pi / 180;

    print('distancia grados.......');
    print(dGr);

    //pasar datos a grados
  }

  _calcularAcimut() {
    // acimut trasmisor-receptor

    // xrxg = xrx;
    // yrxg = yrx;

    print('distacia original');

    print(d);
    double distancia = d!;

    print('distacia cambia');
    print(distancia);

    distancia = distancia / 111.18;
    print('distacia cambia 2');
    print(distancia);

    atr = acos((sin(xrxg!) - cos(distancia) * sin(xtx1!)) /
        (sin(distancia) * cos(xtx1!)));

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
    art = acos((sin(xtx1!) - cos(distancia) * sin(xrxg!)) /
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
    altTxKte = double.parse(altTx.text);
    print('altTxAntKte..-.-.-.-.');
    print(altTxKte);

    altTxAntKte = double.parse(altTxAnt.text);
    print('altTxAntKte..-.-.-.-.');
    print(altTxAntKte);

    altRxKte = double.parse(eleRx.text);
    print('altRxKte---------------------');
    print(altRxKte);

    altrxAntKte = double.parse(eleAntRx.text);

    print('altrxAntKte--------------');
    print(altrxAntKte);

    double h1 = altTxKte! + altTxAntKte!;
    print(h1);
    double h2 = altRxKte! + altrxAntKte!;
    print('h2----------------');
    print(h2);

    double deltAltura = h1 - h2;
    print('deltaAltura');
    print(deltAltura);
    print(d);

    deltAltura = deltAltura / 1000;

    //calculo angulo elevacion
    double alpha = asin((deltAltura / 1000) / d!);

    print('alpha----------------');
    print(alpha);

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

  _calculosLatutudNodoChocarsi() {
    //final horasLatitud = TextEditingController();
    //final minutosLatitu = TextEditingController();
    //final segundosLatit = TextEditingController();
//
    //final horasLongitud = TextEditingController();
    //final minutosLongitud = TextEditingController();
    //final segundosLongitud = TextEditingController();

    horaslatitudkte = 2;
    minutoslatitudkte = 51;
    segudoslatitudkte = 32.43;

    horasLatitud.text = horaslatitudkte.toString();
    minutosLatitu.text = minutoslatitudkte.toString();
    segundosLatit.text = segudoslatitudkte.toString();

    xtx = horaslatitudkte! +
        (minutoslatitudkte! / 60) +
        (segudoslatitudkte! / 3600);

    print(xtx);

    xtxg = xtx;

    if (_sur == true) {
      xtxg = xtxg!;
    } else {
      xtxg = xtxg! * (-1);
    }
    print('latud nodo Chocarsi');
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

  _calculosLatutudNodoOficina() {
    //final horasLatitud = TextEditingController();
    //final minutosLatitu = TextEditingController();
    //final segundosLatit = TextEditingController();
//
    //final horasLongitud = TextEditingController();
    //final minutosLongitud = TextEditingController();
    //final segundosLongitud = TextEditingController();

    horaslatitudkte = 2;
    minutoslatitudkte = 53;
    segudoslatitudkte = 18.91;

    horasLatitud.text = horaslatitudkte.toString();
    minutosLatitu.text = minutoslatitudkte.toString();
    segundosLatit.text = segudoslatitudkte.toString();

    xtx = horaslatitudkte! +
        (minutoslatitudkte! / 60) +
        (segudoslatitudkte! / 3600);

    print(xtx);

    xtxg = xtx;

    if (_sur == true) {
      xtxg = xtxg!;
    } else {
      xtxg = xtxg! * (-1);
    }
    print(' latud nodo Oficina');
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

  _calculosLongitudNodoOficina() {
    horaslongitudkte = 78;
    minutoslongitudkte = 52;
    segundoslongitudkte = 38.74;

    horasLongitud.text = horaslongitudkte.toString();
    minutosLongitud.text = minutoslongitudkte.toString();
    segundosLongitud.text = segundoslongitudkte.toString();

    ytx = horaslongitudkte! +
        (minutoslongitudkte! / 60) +
        (segundoslongitudkte! / 3600);

    ytxg = ytx;

    if (_oeste == true) {
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

  _calculosLongitudNodoChocarsi() {
    horaslongitudkte = 78;
    minutoslongitudkte = 51;
    segundoslongitudkte = 57.66;

    horasLongitud.text = horaslongitudkte.toString();
    minutosLongitud.text = minutoslongitudkte.toString();
    segundosLongitud.text = segundoslongitudkte.toString();

    ytx = horaslongitudkte! +
        (minutoslongitudkte! / 60) +
        (segundoslongitudkte! / 3600);

    ytxg = ytx;

    if (_oeste == true) {
      ytxg = ytxg!;
    } else {
      ytxg = ytxg! * (-1);
    }
    print('longitud nodo Chocarsi');
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

  Future<LocationData> _getLocation() async {
    //LocationData _currentLocation;
    //String _longData = '';
    //String _latData = '';
    //String _altitudData = '';
    //var currentLocation = <String, double>{};
    try {
      _currentLocation = await location.getLocation();
      _longData = _currentLocation!.longitude.toString();
      _latData = _currentLocation!.latitude.toString();
      _altitudData = _currentLocation!.altitude.toString();

      ubialtudCli.text = _altitudData;
      ubilatituCli.text = _latData;
      ubilongitudCli.text = _longData;
      eleRx.text = _altitudData;

      print('--------------------');
      print(_longData);
      print(_latData);
      print(_altitudData);

      print('###############3');
      print(_currentLocation);
    } catch (e) {
      _currentLocation = null!;
    }
    return _currentLocation!;
  }

  _ubicacion() {
    return Row(
      children: [
        userLocation == null ? CircularProgressIndicator() : Text(''),
        RaisedButton(
          onPressed: () {
            _getLocation().then((value) {
              setState(() {
                userLocation = value;
              });
            });
          },
          color: Colors.blue,
          child: Text(
            "Ubicación",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            controller: ubilatituCli,
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
          child: TextField(
            controller: ubilongitudCli,
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
          child: TextField(
            controller: ubialtudCli,
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
}
