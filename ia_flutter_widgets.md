# Widgets e Layouts no Flutter

## 1. Organização estrutural: `Row` e `Column`

Tanto o `Row` (linha) quanto o `Column` (coluna) são widgets de layout que alinham seus filhos em uma única direção.

### `Row` (linha)

- Organiza os widgets filhos horizontalmente, da esquerda para a direita.
- `mainAxisAlignment`: controla o alinhamento no eixo principal (`horizontal` no `Row`).
  - Exemplos: `start`, `end`, `center`, `spaceBetween`, `spaceEvenly`.
- `crossAxisAlignment`: controla o alinhamento no eixo cruzado (`vertical` no `Row`).
  - Exemplos: `start`, `center`, `stretch`.

### `Column` (coluna)

- Organiza os widgets filhos verticalmente, de cima para baixo.
- `mainAxisAlignment`: controla o alinhamento no eixo principal (`vertical` no `Column`).
- `crossAxisAlignment`: controla o alinhamento no eixo cruzado (`horizontal` no `Column`).

## 2. Sobreposição com `Stack`

O widget `Stack` empilha seus filhos uns sobre os outros no eixo Z (profundidade).

- Diferença para `Row`/`Column`: `Stack` permite sobreposição, enquanto `Row` e `Column` evitam que os widgets se sobreponham.
- Caso de uso: texto ou ícone posicionado sobre imagem de fundo.
- Posicionamento default: canto superior esquerdo.
- Para posicionamentos precisos, envolva um filho em `Positioned` e use:
  - `top`, `bottom`, `left`, `right`

## 3. Elementos de conteúdo: `Text` e `Image`

### `Text`

- Aparência controlada por `style`, que recebe um `TextStyle`.
- Propriedades comuns: `fontFamily`, `fontSize`, `color`.
- Para textos longos:
  - `maxLines` limita o número de linhas.
  - `overflow: TextOverflow.ellipsis` adiciona `...` quando o texto ultrapassa o limite.

### `Image`

O Flutter oferece formas diretas de renderizar imagens dependendo da origem.

- Imagem local: `Image.asset('caminho/da/imagem.png')`
  - Lembre-se de registrar a pasta de imagens em `pubspec.yaml`.
- Imagem da internet: `Image.network('https://link-da-imagem.com')`
- Para transições suaves:
  - `FadeInImage` exibe um placeholder e faz fade-in quando a imagem principal estiver carregada.

## 4. Listas dinâmicas: `ListView` e `ListTile`

Quando a tela precisa exibir muitos dados que ultrapassam o tamanho do dispositivo, é necessário usar rolagem.

### `ListView`

- Cria uma lista de rolagem, geralmente vertical.
- `ListView` clássico é útil para poucos itens estáticos.
- `ListView.builder` renderiza itens dinamicamente conforme o usuário rola a tela.
  - Economiza memória e processamento.
- `ListView.separated` funciona como `builder`, mas também adiciona um separador automático entre itens com `separatorBuilder`.

### `ListTile`

- Widget pré-moldado do Material Design para itens de lista.
- Vantagens sobre uma combinação de `Row`, `Column` e `Padding`:
  - Espaçamento automático e layout alinhado.
- Parâmetros principais:
  - `leading`: ícone ou imagem no início.
  - `title`: texto principal.
  - `subtitle`: texto secundário abaixo do título.
  - `trailing`: ícone ou widget final.
- `onTap`: torna o item clicável e adiciona efeito visual de toque (ripple).

## 5. Exemplo prático de layout e lista

O seguinte exemplo mostra um layout básico com `Row`, `Column`, `Stack` e uma lista dinâmica usando `ListView.builder`.

```dart
class LayoutExample extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo de Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Row exemplo', style: TextStyle(fontSize: 16)),
                Icon(Icons.star, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  color: Colors.blue.shade100,
                ),
                const Text(
                  'Stack exemplo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.label),
                    title: Text(items[index]),
                    subtitle: const Text('Descrição do item'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${items[index]} selecionado')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- `Row` alinha widgets horizontalmente.
- `Stack` permite sobrepor widgets.
- `ListView.builder` cria uma lista rolável e dinâmica.
- `ListTile` facilita a construção de cada item com layout de Material Design.
