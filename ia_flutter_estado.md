# Gerenciamento de Estado no Flutter

## 1. O que é gerenciamento de estados?
No Flutter, o estado é qualquer dado que pode mudar ao longo do tempo e que afeta a interface visual.

Exemplos:
- usuário logado ou deslogado
- itens no carrinho de compras
- escolha do tema claro/escuro

Gerenciar o estado significa controlar como e quando esses dados mudam e garantir que a tela seja atualizada corretamente.

## 2. Estado local vs. estado global

### Estado local
O estado local pertence a um único widget e não interessa a mais ninguém na árvore.

- Gerenciado com `StatefulWidget` e `setState()`.
- Exemplo: índice selecionado em uma aba ou o valor de um contador em uma tela.

### Estado global (ou compartilhado)
O estado global precisa ser acessado ou modificado por múltiplos widgets em diferentes telas do app.

- Exemplo: perfil do usuário logado ou preferências de tema.
- Geralmente armazenado em uma camada superior da árvore de widgets.

## 3. Por que usar um gerenciador de estado?

À medida que o app cresce, passar dados manualmente de um widget pai para filhos distantes usando construtores (prop drilling) fica confuso e difícil de manter.

Vantagens de um gerenciador de estado:
- reduz o fluxo de dados direto entre widgets
- separa a lógica de negócios da interface (UI)
- melhora a organização do código
- facilita a manutenção e o reaproveitamento

## 4. O ecossistema do pacote Provider

`Provider` é um dos pacotes de gerenciamento de estado mais recomendados pela comunidade Flutter.

Ele funciona como uma central de distribuição de dados acima da árvore de widgets.

### `ChangeNotifier`
É uma classe nativa do Dart usada pelo Provider.

- encapsula dados e lógica de negócio
- chama `notifyListeners()` quando o estado muda
- avisa os widgets interessados a se reconstruírem

### `ChangeNotifierProvider`
É o widget que conecta a sua classe `ChangeNotifier` à árvore do Flutter.

- fornece o estado para os widgets abaixo
- garante que o estado seja descartado corretamente quando não for mais necessário

## 5. Consumindo dados: `Consumer` vs `Provider.of()`

### `Consumer`
`Consumer` é um widget especializado que escuta as mudanças de estado.

- Possui uma função `builder` que roda novamente sempre que `notifyListeners()` é chamado.
- Permite reconstrução seletiva de partes da UI.
- Ideal para atualizar apenas o item que mudou, evitando reconstruir toda a tela.

### `Provider.of(context)`
Essa é uma forma direta de obter o estado via `context`.

- `listen: true` (padrão): o widget inteiro é reconstruído quando o estado muda.
- `listen: false`: lê o estado apenas uma vez ou obtém uma função, sem escutar mudanças.
  - útil em callbacks de botão, onde só é preciso executar uma ação.

## 6. Comparativo de abordagens

| Critério | `setState()` (estado local) | `Provider` (estado global) |
| --- | --- | --- |
| Escopo | Restrito a um único widget | Acessível pela árvore inteira |
| Reconstrução | Reconstrói o widget inteiro e seus filhos | Permite reconstrução seletiva com `Consumer` |
| Organização | Mistura lógica de negócio com UI | Separa dados e funções em classes independentes (`ChangeNotifier`) |

## 7. Quando usar cada abordagem?

- Use `setState()` para estados simples e locais, quando apenas um widget precisa da informação.
- Use `Provider` (ou outro gerenciador de estado) para estados compartilhados entre várias telas ou widgets distantes.

## 8. Boa prática geral

- Mantenha suas classes de estado limpas e focadas em lógica.
- Evite colocar lógica complexa dentro de widgets.
- Use bons nomes para variáveis e métodos de estado.
- Prefira reconstruir apenas o que realmente precisa ser atualizado.

## 9. Exemplo prático com `Provider`

### Modelo de estado com `ChangeNotifier`

```dart
import 'package:flutter/material.dart';

class ContadorProvider extends ChangeNotifier {
  int _contador = 0;

  int get contador => _contador;

  void incrementar() {
    _contador++;
    notifyListeners();
  }
}
```

### Utilizando `ChangeNotifierProvider`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Exemplo',
      home: const HomePage(),
    );
  }
}
```

### Consumindo o estado com `Consumer`

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Valor do contador:'),
            Consumer<ContadorProvider>(
              builder: (context, contadorProvider, child) {
                return Text(
                  '${contadorProvider.contador}',
                  style: const TextStyle(fontSize: 36),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<ContadorProvider>(context, listen: false).incrementar();
              },
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Por que esse padrão funciona bem?

- `ChangeNotifierProvider` deixa o estado disponível para toda a árvore de widgets.
- `Consumer` reconstrói apenas a parte necessária quando o valor muda.
- `Provider.of(..., listen: false)` permite chamar ações sem forçar a reconstrução do widget.
