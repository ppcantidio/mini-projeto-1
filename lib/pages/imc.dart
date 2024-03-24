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
  final Future<double> imc;

  const WidgetResultadoIMC({Key? key, required this.imc});

  final Map<String, dynamic> _imcMap = {
    'Abaixo do Peso': {'image': '/assets/abaixo.png', 'max': 18.5},
    'Peso Normal': {'image': '/assets/normal.png', 'max': 25},
    'Sobrepeso': {'image': '/assets/sobrepeso.png', 'max': 30},
    'Obesidade Grau I': {'image': '/assets/obesoI.png', 'max': 35},
    'Obesidade Grau II': {'image': '/assets/obesoII.png', 'max': 40},
    'Obesidade Mórbida': {'image': '/assets/morbido.png', 'max': double.infinity},
  };

  String _getStatusIMC(double imc) {
    return _imcMap.keys.firstWhere((k) => imc < _imcMap[k]['max']);
  }

  AssetImage _getImagemIMC(double imc) {
    return AssetImage(_imcMap[_getStatusIMC(imc)]['image']);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: imc,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasData) {
          double imc = snapshot.data!;
          String status = _getStatusIMC(imc);
          AssetImage imagem = _getImagemIMC(imc);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('IMC: ${imc.toStringAsFixed(1)}', style: const TextStyle(fontSize: 16)),
              Image(image: imagem, width: 100, height: 100),
              const SizedBox(height: 10),
              Text(status, style: const TextStyle(fontSize: 16)),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _CalculadoraIMCEstado extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  Future<double> _imc = Future.value(0);

  void _resetar() {
    _alturaController.clear();
    _pesoController.clear();
    _imc = Future.value(0);
  }

  Future<double> _calcularIMC() async {
    double altura = double.tryParse(_alturaController.text) ?? 0.0;
    double peso = double.tryParse(_pesoController.text) ?? 0.0;
    if (peso == 0 || altura == 0) {
      return 0;
    }
    return peso / pow(altura / 100, 2);
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text(widget.title, style: const TextStyle(color: Colors.white)),
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
        body: Form(
          key: _formKey,
          child: ListView(
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _pesoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Informe seu peso (kg)',
                        prefixIcon: Icon(Icons.accessibility),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('Calcular', Colors.blue, () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _imc = _calcularIMC();
                            });
                          }
                        }),
                        const SizedBox(width: 20),
                        _buildButton('Resetar', Colors.red, _resetar),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                      child: WidgetResultadoIMC(imc: _imc),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}