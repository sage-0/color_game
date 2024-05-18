import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color targetColor = Colors.blue;
  List<Color> tileColors = [];
  int score = 0;
  int tileCount = 2;
  Timer? timer;
  int time = 0;
  int CrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    resetGame();
    // Timer setup
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time++;
      });
    });
  }

  void resetGame() {
    final random = Random();
    targetColor = generateRandomColor();
    tileColors = List<Color>.generate(tileCount, (index) => generateRandomColor());
    tileColors[random.nextInt(tileCount)] = targetColor;
  }

  Color generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Score: $score"),
              Container(
                width: 50,
                height: 50,
                color: targetColor,
              ),
              Text("Time: $time"),
            ],
          ),
        ),
        body: GridView.count(
          crossAxisCount: CrossAxisCount,
          children: List.generate(tileCount, (index) {
            return GestureDetector(
              onTap: () {
                if (tileColors[index] == targetColor) {
                  setState(() {
                    score++;
                    CrossAxisCount++;
                    tileCount *= 2;
                    resetGame();
                  });
                }
              },
              child: Container(
                color: tileColors[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}