import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<Color, String>> colors = [
    {Colors.red: "Red"},
    {Colors.green: "Green"},
    {Colors.blue: "Blue"},
    {Colors.yellow: "Yellow"},
    {Colors.orange: "Orange"},
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Color List")),
        body: ListView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final item = colors[index];
            final color = item.keys.first;
            final colorName = item.values.first;
            return ListTile(
              leading: CircleAvatar(backgroundColor: color),
              title: Text(colorName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorPage(color: color, colorName: colorName),
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }
}

class ColorPage extends StatelessWidget {
  final Color color;
  final String colorName;

  const ColorPage({super.key, required this.color, required this.colorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(colorName)),
      body: Container(
        color: color,
        child: Center(
          child: Text(
            colorName,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}