# Persistência de Dados no Flutter

## 1. O que é persistência de dados?
Persistência de dados é a capacidade de salvar informações em um armazenamento não volátil (por exemplo, a memória flash do celular), de modo que elas sobrevivam ao encerramento do aplicativo ou a uma reinicialização do sistema.

### Por que ela é importante?
- **Experiência do usuário (UX)**: evita que o usuário precise reconfigurar o tema, redigitar o nome ou perder o progresso.
- **Uso offline**: permite acessar dados já carregados mesmo sem conexão com a internet.
- **Economia de recursos**: evita requisições repetitivas a servidores para buscar informações estáticas.

## 2. Tipos de dados que podem ser persistidos
Dependendo da complexidade das informações, escolhemos diferentes abordagens de armazenamento no Flutter.

- **Chave-valor simples**: tipos primitivos como booleanos, strings e números, usados para preferências do app.
- **Arquivos locais**: imagens, PDFs ou arquivos de texto salvos diretamente no sistema de arquivos.
- **Bancos de dados relacionais** (ex: SQLite / drift): ideais para volumes grandes de dados interligados, consultas complexas e transações.
- **Bancos de dados NoSQL** (ex: Hive / Isar): armazenamento rápido baseado em documentos ou objetos.

## 3. O pacote `SharedPreferences`

### O que é e como funciona?
`SharedPreferences` é um wrapper que faz a ponte com as APIs nativas de armazenamento.

- No Android, grava dados em arquivos XML via SharedPreferences.
- No iOS, utiliza o `NSUserDefaults`.
- O modelo é de chave-valor, com strings identificadoras únicas para salvar e recuperar dados.

### Limitações do `SharedPreferences`
- **Apenas dados simples**: suporta apenas `int`, `double`, `bool`, `String` e `List<String>`.
- **Desempenho**: carrega o arquivo inteiro na memória durante a inicialização, então não é ideal para grandes volumes ou objetos complexos.
- **Sem buscas avançadas**: não oferece indexação nem recursos de consulta como um banco de dados.

### Quando usar?
Use `SharedPreferences` para dados leves e preferências do usuário:
- tema claro/escuro
- indicar se o usuário já passou pela tela de introdução
- armazenar tokens de autenticação
- salvar pequenos dados de perfil, como nome e sobrenome

## 4. Tratamento de erros e boas práticas

### Lidando com erros
Como `SharedPreferences` faz operações de leitura e escrita no disco, elas retornam `Futures` e podem falhar.

Use `try-catch` e `await` para garantir que a escrita foi concluída com sucesso:

```dart
try {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', 'João');
} catch (erro) {
  print('Falha ao salvar preferências: $erro');
}
```

### Melhores práticas
- **Instância centralizada**: evite chamar `SharedPreferences.getInstance()` repetidamente. Inicialize uma vez no início do app ou gerencie com um serviço/Provider.
- **Uso de constantes**: não digite chaves como strings soltas no código.

```dart
static const String keyUserName = 'user_name';
```

- **Serialize listas complexas**: para uma lista de objetos estruturados, converta para JSON antes de salvar e decodifique ao ler.

```dart
final tarefasJson = jsonEncode(listaDeTarefas);
await prefs.setString('tarefas', tarefasJson);
```

## 5. Conclusão
`SharedPreferences` é excelente para preferências leves e dados simples. Para registros mais complexos ou grandes volumes de informações, prefira bancos de dados locais como SQLite, Hive ou Isar.
