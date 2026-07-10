# Rotas e Navegação no Flutter

## 1. Navegação com rotas anônimas

### O que são e como funcionam?
Rotas anônimas são criadas diretamente no momento da navegação, sem um registro prévio de nome.

Para navegar anonimamente, usamos `Navigator.push()` combinado com `MaterialPageRoute`:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SegundaTela()),
);
```

- `Navigator.push()`: adiciona uma nova tela ao topo da pilha de navegação.
- `Navigator.pop()`: remove a tela atual do topo da pilha, retornando o usuário para a tela anterior.

### Vantagens e desvantagens

- Vantagens:
  - Rápida de implementar.
  - Ideal para passar parâmetros diretamente pelo construtor da nova tela.
- Desvantagens:
  - O código de navegação pode ficar espalhado pelo projeto.
  - Dificulta a manutenção e a visualização centralizada do fluxo do app.

## 2. Navegação com rotas nomeadas

### O que são e como funcionam?
Rotas nomeadas funcionam como URLs de um site. Você define strings pré-configuradas (como `/home` ou `/detalhes`) para representar cada tela no aplicativo.

### Como definir e navegar

As rotas nomeadas são registradas no parâmetro `routes` do `MaterialApp`:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => TelaInicial(),
    '/detalhes': (context) => TelaDetalhes(),
  },
);
```

Para navegar entre elas, use:

```dart
Navigator.pushNamed(context, '/detalhes');
```

### Vantagens das rotas nomeadas

- Organização: todas as telas ficam mapeadas em um único lugar.
- Legibilidade: o código de navegação fica mais limpo.

## 3. Passagem de parâmetros em rotas nomeadas

Para enviar dados ao navegar com rotas nomeadas, use o argumento `arguments`:

```dart
Navigator.pushNamed(
  context,
  '/detalhes',
  arguments: 'Informação extra enviada',
);
```

### Como extrair o parâmetro na tela de destino

No `build` da tela receptora, capture os dados a partir do contexto:

```dart
final dadosRecebidos = ModalRoute.of(context)!.settings.arguments;
```

### Parâmetros opcionais

Para parâmetros opcionais, use estruturas flexíveis como `Map<String, dynamic>` ou crie classes de argumentos com atributos nulos (`null`).

## 4. Cuidados e boas práticas com rotas

- Evite vazamento de memória: encerre controladores e animações com `dispose()` quando a tela sair da pilha.
- Use constantes para nomes de rota:
  - Por exemplo: `static const String routeName = '/detalhes';`
- Evite pilhas infinitas: em loops de navegação, prefira `Navigator.pushReplacementNamed()` para substituir a tela atual em vez de empilhar telas iguais.
