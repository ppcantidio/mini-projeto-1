import 'package:flutter/material.dart';
import 'dart:math';

class FormAtv extends StatelessWidget {
  const FormAtv({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Aplication';
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: const Text(title, style: TextStyle(color: Colors.white)),
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
          body: ListView(children: [
            ListTile(
              title: const Text('Personal info',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Firstname',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Lastname',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Birthday',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'MM/DD/AAAA',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Social Security',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '###-##-###',
                        style: TextStyle(
                          color: Colors.grey, // Cor do texto
                          fontSize: 12, // Tamanho da fonte
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            ListTile(
              title: const Text('Residence address',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'City',
                    ),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'State',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'ZIP Code',
                    ),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Country',
                        suffixIcon: Icon(
                            Icons.arrow_drop_down), // Ícone ao lado direito
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({super.key});

  static EdgeInsets? safeAreaPadding;

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> cores = [
      [Colors.red, Colors.red, Colors.red, Colors.green],
      [Colors.red, Colors.red, Colors.blue, Colors.yellow],
      [Colors.red, Colors.green, Colors.yellow, Colors.yellow],
      [Colors.blue, Colors.yellow, Colors.yellow, Colors.yellow],
      [Colors.green, Colors.green, Colors.red, Colors.yellow],
      [Colors.green, Colors.green, Colors.green, Colors.blue],
    ];

    safeAreaPadding ??= MediaQuery.of(context).padding;

    double screenHeight = MediaQuery.of(context).size.height -
        (safeAreaPadding!.top + safeAreaPadding!.bottom);
    double screenWidth = MediaQuery.of(context).size.width;

    double height = screenHeight / 6;
    double width = screenWidth / 4;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: cores.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                for (int j = 0; j < cores[index].length; j++)
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    height: height,
                    color: cores[index][j],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

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

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const HomePage());
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Grid'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Grid()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Form'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormAtv()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('IMC'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CalculadoraIMC(title: 'Calculadora IMC')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
