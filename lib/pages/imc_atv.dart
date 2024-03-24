import 'package:flutter/material.dart';
import 'dart:math';

enum Genero { Masculino, Feminino }

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCEstado();
}

class WidgetResultadoIMC extends StatelessWidget {
  final double imc;

  const WidgetResultadoIMC({Key? key, required this.imc});

  String _getStatusIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc < 25) {
      return 'Peso Normal';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc < 40) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Mórbida';
    }
  }

  AssetImage _getImagemIMC(double imc) {
    if (imc < 18.5) {
      return const AssetImage('/assets/abaixo.png');
    } else if (imc < 25) {
      return const AssetImage('/assets/normal.png');
    } else if (imc < 30) {
      return const AssetImage('/assets/sobrepeso.png');
    } else if (imc < 35) {
      return const AssetImage('/assets/obesoI.png');
    } else if (imc < 40) {
      return const AssetImage('/assets/obesoII.png');
    } else {
      return const AssetImage('/assets/morbido.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    String status = _getStatusIMC(imc);
    AssetImage imagem = _getImagemIMC(imc);

    if (imc == 0) {
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            'IMC: ${imc.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Image(
          image: imagem,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            status,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _CalculadoraIMCEstado extends State<CalculadoraIMC> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  double _altura = 0;
  double _peso = 0;
  double _imc = 0;

  Genero? _genero = Genero.Masculino;

  void _resetar() {
    setState(() {
      _alturaController.clear();
      _pesoController.clear();
      _altura = 0;
      _peso = 0;
      _imc = 0;
    });
  }

  double _calcularIMC(double altura, double peso) {
    if (peso == 0 || altura == 0) {
      return 0;
    }
    return peso / pow(altura / 100, 2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert_sharp, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Informe sua altura (cm)',
                      prefixIcon: Icon(Icons.design_services),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _altura = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Informe seu peso (kg)',
                      prefixIcon: Icon(Icons.accessibility),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _peso = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _imc = _calcularIMC(_altura, _peso);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Calcular',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _resetar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Resetar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                    child: WidgetResultadoIMC(imc: _imc),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
