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
      home: Scaffold(
        
        backgroundColor: const Color(0xFF0F2027),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                buildStackedCard(
                  backgroundColor: Colors.grey,
                  colors: [Colors.red, Colors.green, Colors.blue],
                ),
                const SizedBox(width: 16), 
                
                buildStackedCard(
                  backgroundColor: Colors.black,
                  colors: [Colors.cyan, Colors.purple, Colors.yellow],
                ),
                const SizedBox(width: 16),

                
                buildStackedCard(
                  backgroundColor: Colors.transparent,
                  colors: [Colors.red, Colors.yellow, Colors.blue],
                ),
                const SizedBox(width: 16),

                
                buildStackedCard(
                  backgroundColor: Colors.white,
                  colors: [
                    Colors.deepPurple,
                    Colors.deepOrange,
                    Colors.yellow,
                    Colors.lightGreen,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget buildStackedCard({
    required Color backgroundColor,
    required List<Color> colors,
  }) {
    return Container(
      width: 100,
      height: 100,
      color: backgroundColor,
      child: Stack(
        children: List.generate(colors.length, (index) {
          
          final double offset = 10.0 + (index * 10.0);

          return Positioned(
            top: offset,
            left: offset,
            child: Container(width: 50, height: 50, color: colors[index]),
          );
        }),
      ),
    );
  }
}
