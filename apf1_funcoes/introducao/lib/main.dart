import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Color corAleatoria() {
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

final random = Random();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('esse texto vai ter a cor mudada'),
          titleTextStyle: TextStyle(color: corAleatoria(), fontSize: 25),
        ),
        floatingActionButton: FloatingActionButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.color_lens),
              SizedBox(height: 2),
              Text('Sortear cor', style: TextStyle(fontSize: 10)),
            ],
          ),
          onPressed: () {
            setState(() {
              backgroundColor = corAleatoria();
            });
          },
        ),
      ),
    );
  }
}
