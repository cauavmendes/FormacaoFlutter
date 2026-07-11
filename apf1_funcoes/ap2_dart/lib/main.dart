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
      home: const TelaJogo(),
    );
  }
}

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final List<String> botoes = ['A', 'B', 'C'];

  late String botaoCorreto;

  int tentativas = 2;
  bool fimDeJogo = false;

  Color corFundo = Colors.white;
  String mensagem = "Escolha um botão";

  @override
  void initState() {
    super.initState();
    botaoCorreto = botoes[Random().nextInt(3)];
  }

  void verificarBotao(String botao) {
    if (fimDeJogo) return;

    setState(() {
      if (botao == botaoCorreto) {
        corFundo = Colors.green;
        mensagem = "Você venceu!";
        fimDeJogo = true;
      } else {
        tentativas--;

        if (tentativas == 0) {
          corFundo = Colors.red;
          mensagem = "Você perdeu!";
          fimDeJogo = true;
        } else {
          mensagem = "Errado! Resta $tentativas tentativa(s).";
        }
      }
    });
  }

  void reiniciarJogo() {
    setState(() {
      botaoCorreto = botoes[Random().nextInt(3)];
      tentativas = 2;
      fimDeJogo = false;
      corFundo = Colors.white;
      mensagem = "Escolha um botão";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(title: const Text("Jogo dos Botões"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensagem,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: fimDeJogo ? null : () => verificarBotao("A"),
              child: const Text("A"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: fimDeJogo ? null : () => verificarBotao("B"),
              child: const Text("B"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: fimDeJogo ? null : () => verificarBotao("C"),
              child: const Text("C"),
            ),

            const SizedBox(height: 40),

            if (fimDeJogo)
              ElevatedButton(
                onPressed: reiniciarJogo,
                child: const Text("Jogar novamente"),
              ),
          ],
        ),
      ),
    );
  }
}
