# Formulários no Flutter

## 1. Entrada de texto: `TextField` vs `TextFormField`

### O que é o `TextField`?
O `TextField` é o widget básico do Flutter para capturar entrada de texto do usuário, como nome, senha ou e-mail.

#### Parâmetros principais
- `controller`: um objeto `TextEditingController` usado para ler, modificar ou limpar o texto programaticamente.
- `keyboardType`: define o tipo de teclado virtual (por exemplo, `TextInputType.emailAddress` ou `TextInputType.number`).
- `maxLength`: limita a quantidade máxima de caracteres.
- `decoration`: recebe um `InputDecoration` para personalizar o visual com `hintText`, `labelText`, `icon`, `prefixIcon` e `suffixIcon`.

### Diferença fundamental: `TextField` vs `TextFormField`
- `TextField`: campo puro. Se precisar de validação ou integração com um formulário, você gerencia tudo manualmente.
- `TextFormField`: wrapper em torno de `TextField` projetado para funcionar dentro de um `Form`.
  - Suporte nativo a validação através de `validator`.
  - Facilita o salvamento automático e o controle de estado do formulário.

## 2. Validação de campos

Validar um campo significa verificar se o texto inserido atende a requisitos específicos antes de enviar os dados.

### Mensagens de erro e funcionamento
No `TextFormField`, o parâmetro `validator` recebe uma função que analisa o texto atual.
- Se o texto for inválido, a função retorna uma `String` com a mensagem de erro (por exemplo, `E-mail inválido`).
- Se o texto estiver correto, a função retorna `null`.

### Validação síncrona x assíncrona
- Síncrona: acontece instantaneamente no dispositivo.
  - Exemplo: verificar se o campo está vazio ou se contém o caractere `@` em um e-mail.
- Assíncrona: depende de uma resposta externa e demora mais.
  - Exemplo: enviar requisição a um servidor para verificar se o nome de usuário já está cadastrado.

## 3. Seleções: `Checkbox` e `Radio`

Além de textos, formulários geralmente precisam de opções de múltipla escolha ou escolha única.

### `Checkbox`
- Finalidade: usado para seleções do tipo `ligado/desligado` ou quando o usuário pode marcar várias opções independentes.
  - Exemplo: `Aceitar termos e condições`.
- Personalização:
  - `activeColor`: cor de preenchimento quando marcado.
  - `checkColor`: cor do ícone de marcação.
  - `fillColor`: cor do fundo.

### `Radio`
- Finalidade: usado quando o usuário deve escolher apenas uma opção dentro de um grupo exclusivo.
  - Exemplo: `Sim` ou `Não` em uma pergunta.
- Funcionamento:
  - Cada `Radio` possui um `value` e um `groupValue`.
  - Quando `value` é igual a `groupValue`, o botão aparece marcado.
- Personalização:
  - `activeColor`, `fillColor` e outras opções de estilo.

## 4. Boas práticas em formulários

- Use `Form` e `GlobalKey<FormState>` para controlar o estado do formulário.
- Separe validação de apresentação sempre que possível.
- Evite lógica pesada dentro de `validator`.
- Atualize o estado com `setState` apenas quando for necessário.

## 5. Exemplo prático de formulário

Abaixo está um exemplo de formulário simples com dois campos de texto, validação e um `Checkbox`.

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptedTerms = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() == true && _acceptedTerms) {
      // Aqui você processa os dados ou envia para a API.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulário enviado com sucesso!')),
      );
    } else if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você precisa aceitar os termos')), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O e-mail é obrigatório';
                }
                if (!value.contains('@')) {
                  return 'Digite um e-mail válido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A senha é obrigatória';
                }
                if (value.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text('Aceito os termos e condições'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
```

- `Form` envolve os campos e permite validar todos ao mesmo tempo.
- `GlobalKey<FormState>` permite acessar o estado do formulário.
- `validator` valida cada campo individualmente.
- O `Checkbox` garante que o usuário aceite os termos antes de enviar.

Se quiser, posso também incluir um exemplo com `Radio` para escolha única.
