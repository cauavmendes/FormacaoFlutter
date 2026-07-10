# Programação Assíncrona no Flutter

Mais um excelente passo na sua evolução pela Lince Tech Academy! Agora entramos em um dos pilares mais importantes do desenvolvimento mobile moderno: programação assíncrona e consumo de APIs. Sem esse conhecimento, os aplicativos travariam a tela a cada clique ou carregamento de dados.

## 1. Fundamentos da programação assíncrona

### O que é e por que importa?
A programação assíncrona permite que o aplicativo execute tarefas demoradas (como baixar dados da internet ou ler um arquivo) em segundo plano, sem travar a interface do usuário (UI). Como o Flutter roda nativamente a 60fps ou 120fps, qualquer bloqueio na thread principal causa aquelas travadas desconfortáveis conhecidas como jank.

### O Event Loop (Loop de Eventos)
O Dart é uma linguagem single-threaded por padrão, então ele usa o Event Loop para gerenciar o fluxo de execução.

- `Microtask Queue`: tarefas internas curtas e prioritárias.
- `Event Queue`: eventos externos, como toques na tela, timers e respostas de requisições de rede.

O Event Loop processa um evento por vez e só então passa para o próximo.

### O que são isolates?
Quando é necessário fazer um cálculo muito pesado, o Event Loop não dá conta e a tela trava. Para isso servem os isolates.

- Isolates criam espaços de memória separados do fluxo principal.
- Eles permitem processamento paralelo sem bloquear a UI.
- Atenção: isolates não compartilham memória diretamente.
- A comunicação entre isolates é feita por mensagens usando `SendPort` e `ReceivePort`.

## 2. Trabalhando com `Future`, `async` e `await`

### O conceito de `Future`
Um `Future` representa um valor ou erro que estará disponível em algum momento no futuro. É como o comprovante de um pedido: você faz a solicitação, recebe o comprovante e depois aguarda o resultado.

### Usando `async` e `await`
Para deixar o código assíncrono legível e com aparência de código sequencial, usamos:

- `async`: indica que a função contém operações assíncronas e retorna um `Future`.
- `await`: faz o código pausar naquela linha até que o `Future` seja resolvido, sem congelar o app.

### Tratamento de erros com `try-catch`
Erros de conexão são comuns no mobile. Proteja seu aplicativo usando `try-catch`:

```dart
try {
  var dados = await buscarDadosNaInternet();
} catch (erro) {
  print('Ocorreu um erro: $erro');
}
```

## 3. Requisições HTTP e códigos de resposta

No Flutter, a conexão com servidores normalmente é feita com o pacote oficial `http`.

### Principais métodos HTTP
- `GET`: busca/recupera informações do servidor.
- `POST`: envia novos dados para serem cadastrados.
- `PUT` / `PATCH`: atualizam dados já existentes.
- `DELETE`: remove um recurso específico.

### Lidando com status codes
- `200 (OK)` / `201 (Created)`: sucesso.
- `404 (Not Found)`: recurso não encontrado.
- `500 (Internal Server Error)`: erro no servidor.

## 4. Manipulação de JSON e serialização de classes

As APIs costumam responder em JSON, que no Flutter vira `Map<String, dynamic>`.

### O problema do JSON puro
Acessar dados diretamente por chaves de texto (`resultado['usuario']['nome']`) é arriscado. Se ocorrer um erro de digitação, o app quebra em tempo de execução.

### Mapeando JSON para classes Dart
A melhor prática é transformar JSON em classes Dart estruturadas.

- Garante tipagem estática.
- Permite autocomplete no editor.
- Reduz bugs em tempo de execução.

### Padrões recomendados
- `factory MyModel.fromJson(Map<String, dynamic> json)`: cria uma instância a partir do JSON.
- `Map<String, dynamic> toJson()`: converte um objeto Dart em JSON.

## 5. Boas práticas e feedback visual

- Componentes de carregamento: exiba `CircularProgressIndicator` enquanto aguarda um `Future`.
- Nunca faça requisições HTTP diretamente nos widgets.
- Crie classes separadas como `Services` ou `Repositories` para isolar a lógica de rede.

Essas práticas garantem um código mais limpo, testável e menos propenso a erros.

## 6. Exemplos práticos

### 6.1 Exemplo de `async` / `await` com erro tratado

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> buscarUsuario() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');

  try {
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      return jsonDecode(resposta.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao carregar usuário: ${resposta.statusCode}');
    }
  } catch (erro) {
    throw Exception('Erro de conexão: $erro');
  }
}
```

- `await http.get()` faz a requisição sem travar a UI.
- `try-catch` captura falhas de rede e conversão de dados.
- `statusCode` garante que a resposta foi bem-sucedida.

### 6.2 Exemplo de `FutureBuilder` para consumir API

```dart
class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  Future<Map<String, dynamic>> carregarUsuario() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      return jsonDecode(resposta.body) as Map<String, dynamic>;
    }

    throw Exception('Erro ao buscar usuário');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuário')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: carregarUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final usuario = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${usuario['name']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('E-mail: ${usuario['email']}'),
                const SizedBox(height: 8),
                Text('Cidade: ${usuario['address']['city']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

- `FutureBuilder` simplifica a exibição de estados: loading, sucesso e erro.
- `snapshot.connectionState` indica o estado da requisição.
- Use `snapshot.hasData` e `snapshot.hasError` para tratar os diferentes resultados.

