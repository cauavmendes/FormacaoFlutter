import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

enum EstadoJogo { jogando, ganhou, perdeu }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: MyWidget())),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final random = Random();

  int vitorias = 0;
  int derrotas = 0;
  var botaoCorreto = 0;
  var clicks = 0;
  EstadoJogo estado = EstadoJogo.jogando;

  // Esse método e chamado somente uma vez, ao iniciar o state
  @override
  void initState() {
    super.initState();

    // Escolher um número de 0 a 2 para identificar escolher o botão correto
    botaoCorreto = random.nextInt(3);
  }

  // Tratar a tentativa do usuário
  void tentativa(int opcao) {
    setState(() {
      if (estado != EstadoJogo.jogando) return;

      if (botaoCorreto == opcao) {
        estado = EstadoJogo.ganhou;
        vitorias++;
      } else {
        clicks++;
        if (clicks >= 2) {
          derrotas++;
          estado = EstadoJogo.perdeu;
        }
      }
    });
  }

  void reiniciar() {
    setState(() {
      botaoCorreto = random.nextInt(3);
      clicks = 0;
      estado = EstadoJogo.jogando;
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (estado) {
      EstadoJogo.jogando => TelaJogando(
        onClick: tentativa,
        vitorias: vitorias,
        derrotas: derrotas,
      ),
      EstadoJogo.ganhou => TelaGanhou(onReiniciar: reiniciar),
      EstadoJogo.perdeu => TelaPerdeu(onReiniciar: reiniciar),
    };
  }
}

class TelaJogando extends StatelessWidget {
  final void Function(int) onClick;
  final int vitorias;
  final int derrotas;

  const TelaJogando({
    super.key,
    required this.onClick,
    required this.vitorias,
    required this.derrotas,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Vitórias: $vitorias', style: const TextStyle(fontSize: 20)),
          Text('Derrotas: $derrotas', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => onClick(0), child: const Text('A')),
          ElevatedButton(onPressed: () => onClick(1), child: const Text('B')),
          ElevatedButton(onPressed: () => onClick(2), child: const Text('C')),
        ],
      ),
    );
  }
}

class TelaGanhou extends StatelessWidget {
  final VoidCallback onReiniciar;

  const TelaGanhou({super.key, required this.onReiniciar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Você ganhou!', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onReiniciar,
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }
}

class TelaPerdeu extends StatelessWidget {
  final VoidCallback onReiniciar;

  const TelaPerdeu({super.key, required this.onReiniciar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Você perdeu!', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onReiniciar,
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }
}
