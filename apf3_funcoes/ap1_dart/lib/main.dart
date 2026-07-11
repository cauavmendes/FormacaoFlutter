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
  @override
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  bool inativo = false;

  String nomeSalvo = '';
  int idadeSalva = 0;
  bool inativoSalvo = false;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    if (value.length < 3) {
                      return 'O nome deve ter pelo menos 3 caracteres';
                    }
                    if (value[0] != value[0].toUpperCase()) {
                      return 'O nome deve começar com letra maiúscula';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10.0),
                TextFormField(
                  controller: idadeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Idade'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma idade';
                    }
                    int? idade = int.tryParse(value);
                    if (idade == null) {
                      return 'Por favor, insira um número válido';
                    }
                    if (idade < 18) {
                      return 'A idade deve ser maior ou igual a 18';
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Inativo'),
                  value: inativo,
                  onChanged: (bool? value) {
                    setState(() {
                      inativo = value ?? false;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        nomeSalvo = nomeController.text;
                        idadeSalva = int.parse(idadeController.text);
                        inativoSalvo = inativo;
                      });
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: inativoSalvo ? Colors.grey : Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome: $nomeSalvo'),
                      Text('Idade: $idadeSalva'),
                      Text('Status: ${inativoSalvo ? "Inativo" : "Ativo"}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
