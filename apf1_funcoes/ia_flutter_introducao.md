# Introdução ao Flutter

## 1. Estrutura inicial: imports e `MaterialApp`

### Como funcionam os imports no Flutter?
No Flutter, os imports são usados para incluir bibliotecas, pacotes ou outros arquivos de código no seu arquivo atual. Eles permitem reutilizar componentes existentes.

A estrutura padrão para importar o pacote de design visual do Flutter é:

```dart
import 'package:flutter/material.dart';
```

- `package:` indica que estamos buscando uma dependência externa ou interna configurada em `pubspec.yaml`.
- `flutter/material.dart` é o pacote principal que contém todos os componentes visuais baseados no Material Design (botões, barras de navegação, textos etc.).

### O que é o `MaterialApp` e seus parâmetros importantes?
O `MaterialApp` é o widget raiz de quase todas as aplicações Flutter voltadas para Android/Web. Ele configura os elementos globais de design da aplicação, como rotas, temas e localização.

Principais parâmetros:

- `home`: widget que define a tela inicial do aplicativo.
- `theme`: define a paleta de cores, tipografia e estilos globais através de `ThemeData`.
- `routes`: dicionário (`Map`) que define as rotas de navegação nomeadas do app.
- `debugShowCheckedModeBanner`: booleano (geralmente `false` em produção) que remove a faixa vermelha com "DEBUG" no canto superior direito.

## 2. Material Design no Flutter

O Material Design é o sistema de design criado pelo Google para unificar a experiência visual em interfaces digitais, com foco em sombras, grids, animações e responsividade. No Flutter, ele já vem implementado de forma nativa e componentizada.

Principais widgets do Material Design:

- `Scaffold`: esqueleto de uma tela estruturada, com `AppBar`, `body` e `FloatingActionButton`.
- `AppBar`: barra de ferramentas superior da tela.
- `FloatingActionButton` (FAB): botão circular flutuante usado para a ação principal.
- `ElevatedButton` / `TextButton`: botões com e sem relevo, respectivamente.

## 3. Widgets: Stateless vs Stateful

A principal regra do Flutter é: tudo é um widget. A interface é reconstruída com base no estado dos dados.

### Widgets Stateless (sem estado)

- São widgets imutáveis.
- Depois de criados, suas propriedades não mudam até que o widget pai os reconstrua com novos dados.

Quando usar:

- Telas estáticas
- Ícones
- Textos simples
- Botões que apenas disparam ações fixas

Ciclo de vida:

- Construtor
- `build()`

Limitações:

- Não conseguem reagir a interações do usuário de forma autônoma (por exemplo, mudar de cor sozinho ao ser clicado).

### Widgets Stateful (com estado)

- São widgets mutáveis.
- Conseguem armazenar informações internas que mudam durante a execução.
- Podem forçar a atualização da tela quando esses dados mudam.

Quando usar:

- Formulários
- Contadores
- Listas dinâmicas que buscam dados da internet
- Telas com animações

Como funciona o `setState`:

- `setState()` avisa ao Flutter que os dados internos mudaram e que o `build()` deve ser executado novamente para atualizar a UI.

Ciclo de vida principal:

- `createState()`
- `initState()`
- `build()`
- `dispose()`

### Comparativo direto

| Elemento | Tipo de widget ideal | Motivo |
| --- | --- | --- |
| Nome dos times | `StatelessWidget` | O nome do time não vai mudar no meio da partida. |
| Contador de gols | `StatefulWidget` | O número muda toda vez que um gol é marcado. |

Cuidados no gerenciamento de estado:

- Evite colocar lógica de negócio pesada dentro de `setState`.
- Não chame `setState` em loops ou de forma desnecessária.
- Reconstruir a árvore de widgets a todo momento pode prejudicar o desempenho do app.

## 4. Exemplo prático: `StatelessWidget` vs `StatefulWidget`

A seguir, um exemplo simples que mostra um widget estático e outro que atualiza o contador ao pressionar um botão.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Introdução ao Flutter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Este é um widget Stateless:'),
            const SizedBox(height: 8),
            const StaticText(),
            const SizedBox(height: 24),
            const Text('Este é um widget Stateful:'),
            const SizedBox(height: 8),
            Text('Contador: $_counter', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StaticText extends StatelessWidget {
  const StaticText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Eu não mudo quando o botão é pressionado.',
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}
```

- `MyApp` e `StaticText` são exemplos de `StatelessWidget`.
- `HomePage` e `_HomePageState` mostram um `StatefulWidget` que atualiza a interface com `setState()`.
- O botão flutuante aumenta o valor do contador e força a reconstrução do widget.


