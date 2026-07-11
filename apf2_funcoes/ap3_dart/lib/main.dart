import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormatosDinamicosScreen(),
    );
  }
}

class FormatosDinamicosScreen extends StatefulWidget {
  const FormatosDinamicosScreen({super.key});

  @override
  State<FormatosDinamicosScreen> createState() =>
      _FormatosDinamicosScreenState();
}

class _FormatosDinamicosScreenState extends State<FormatosDinamicosScreen> {
  bool _isCircle = true;
  Color _shapeColor = Colors.amber;
  final Random _random = Random();

  // Função para alternar a forma
  void _toggleShape() {
    setState(() {
      _isCircle = !_isCircle;
    });
  }

  void _changeColor() {
    setState(() {
      _shapeColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      body: Center(
        child: Container(
          width: 400,
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF132230),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1B26),
                      foregroundColor: const Color(0xFFD0BCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _toggleShape,
                    child: Text(
                      _isCircle ? "Mudar para quadrado" : "Mudar para círculo",
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1B26),
                      foregroundColor: const Color(0xFFD0BCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _changeColor,
                    child: const Text("Cor aleatoria"),
                  ),
                ],
              ),
              const Spacer(),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _shapeColor,
                  shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
