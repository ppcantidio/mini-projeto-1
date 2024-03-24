import 'package:flutter/material.dart';

class GridAtv extends StatelessWidget {
  const GridAtv({super.key});

  static EdgeInsets? safeAreaPadding;

  final Map<int, List<Color>> cores = {
    0: [Colors.red, Colors.red, Colors.red, Colors.green],
    1: [Colors.red, Colors.red, Colors.blue, Colors.yellow],
    2: [Colors.red, Colors.green, Colors.yellow, Colors.yellow],
    3: [Colors.blue, Colors.yellow, Colors.yellow, Colors.yellow],
    4: [Colors.green, Colors.green, Colors.red, Colors.yellow],
    5: [Colors.green, Colors.green, Colors.green, Colors.blue],
  };

  Widget _buildContainer(Color color, double width, double height) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    safeAreaPadding ??= MediaQuery.of(context).padding;

    double screenHeight = MediaQuery.of(context).size.height -
        (safeAreaPadding!.top + safeAreaPadding!.bottom);
    double screenWidth = MediaQuery.of(context).size.width;

    double height = screenHeight / 6;
    double width = screenWidth / 4;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: width / height,
          ),
          itemCount: cores.length * 4,
          itemBuilder: (BuildContext context, int index) {
            int row = index ~/ 4;
            int col = index % 4;
            return _buildContainer(cores[row][col], width, height);
          },
        ),
      ),
    );
  }
}