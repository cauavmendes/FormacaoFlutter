import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 250,
            height: 310,
            color: Colors.blueGrey[900],
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 50, height: 50, color: Colors.red),
                      SizedBox(width: 8),
                      Container(width: 50, height: 50, color: Colors.green),
                      SizedBox(width: 8),
                      Container(width: 50, height: 50, color: Colors.blue),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Colors.yellow,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        Container(width: 50, height: 100, color: Colors.purple),
                        SizedBox(width: 8),
                        Container(width: 50, height: 100, color: Colors.cyan),
                        SizedBox(width: 8),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: 50,
                              height: 50,
                              color: Colors.purple,
                            ),

                            Container(
                              margin: const EdgeInsets.all(8),
                              width: 50,
                              height: 50,
                              color: Colors.cyan,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 70,
                    color: Colors.grey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 50, height: 50, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
