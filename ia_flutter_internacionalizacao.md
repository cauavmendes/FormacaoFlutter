# Internacionalização no Flutter

## 1. O que é internacionalização?
Internacionalização (i18n) é o processo de projetar um aplicativo para que ele possa ser facilmente adaptado a diferentes idiomas e regiões sem mudar sua estrutura interna.

### Por que ela é importante?
- **Alcance global**: permite publicar o app em diferentes países e atender usuários de novas regiões.
- **Experiência localizada (l10n)**: além da tradução de textos, adaptar formatos de data, moeda e números faz o app parecer nativo na região do usuário.

## 2. Como funciona a internacionalização no Flutter

No Flutter, a internacionalização geralmente usa pacotes oficiais como `flutter_localizations` e `intl`.

O fluxo padrão é:
- **Configurar `locales`** no `MaterialApp`.
- **Adicionar `localizationsDelegates`** para informar ao Flutter como traduzir componentes nativos.
- **Gerar código** com `flutter gen-l10n` a partir de arquivos de tradução.
- **Usar `AppLocalizations.of(context)`** para acessar textos traduzidos.

## 3. O uso de arquivos ARB (.arb)

Os arquivos ARB (Application Resource Bundle) são o padrão recomendado para gerenciar traduções no Flutter.

### Como funcionam?
- Cada texto é definido como uma chave única.
- O valor é a tradução daquela chave.
- O arquivo é baseado em JSON.

### Boas práticas para arquivos ARB
- **Estrutura chave-valor**:
  - `app_en.arb`: `{"helloWorld": "Hello World"}`
  - `app_pt.arb`: `{"helloWorld": "Olá Mundo"}`
- **Placeholders**:
  - Use variáveis como `{username}` para textos dinâmicos.
- **Descrições contextuais**:
  - Adicione comentários `@minhaChave` para explicar o uso do texto aos tradutores.

## 4. Boas práticas com `intl`

O pacote `intl` é poderoso, mas requer cuidado.

### Cuidados importantes
- **Inicialização assíncrona**:
  - Formatos de idioma dependem do carregamento correto dos dados de localização.
  - Certifique-se de aguardar a identificação do idioma do dispositivo antes de renderizar a UI.
- **Quebras de layout**:
  - Idiomas como alemão ou português podem ter textos mais longos.
  - Use widgets flexíveis como `Flexible` ou `Wrap` para evitar overflow.
- **Geração de código limpa**:
  - Sempre rode `flutter gen-l10n` após adicionar ou alterar uma chave no arquivo ARB.

## 5. Formatação de data, hora e moeda
A internacionalização vai além da tradução de palavras. Também envolve adaptar a exibição de datas, horas e valores numéricos.

### Formatação de moedas
Use `NumberFormat.currency()` para ajustar valores conforme a localidade.

```dart
import 'package:intl/intl.dart';

final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
print(formatador.format(1000.5)); // R$ 1.000,50
```

### Formatação de data e hora
Use `DateFormat` para gerar datas no formato correto do usuário.

```dart
import 'package:intl/intl.dart';

final data = DateTime.now();
final formatadorBrasil = DateFormat.yMd('pt_BR');
final formatadorEUA = DateFormat.yMd('en_US');
print(formatadorBrasil.format(data)); // 10/07/2026
print(formatadorEUA.format(data)); // 07/10/2026
```

## 6. Exemplo de configuração básica no `MaterialApp`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}
```

## 7. Conclusão
A internacionalização aumenta o alcance do seu aplicativo e melhora a experiência do usuário ao tornar sua interface mais natural e atraente para diferentes culturas.
