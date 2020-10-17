# Images.APP

Trata-se do front-end do aplicativo móvel em desenvolvido em Flutter* com
funções de cadastrar, listar, excluir, like e dislike em imagens, consumindo da
API criada em .NET

## Instalação
Para buildar o aplicativo, torna-se necessária a instalação do SDK Flutter e dos
plugins do Flutter e Dart na IDE, para o desenvolvimento do projeto foi
utilizado o Visual Studio Code (VS Code), entretanto, não se torna mandatório o
uso desse editor de texto. Ao final desta documentação haverá um link com
instruções de instalação do mesmo.

Após a configuração do ambiente de desenvolvimento, entre no arquivo
interceptor.dart afim de conferir se a instrução de URL localizada na linha 6 é a
mesma que está sendo utilizada pela API.

Por fim, existem duas possibilidades para testar o aplicativo, listadas abaixo:

1- Com o Vs Code Aberto clique em Run e em Debug

2- No terminal do Linux / MacOSX ou no prompt de comando do Windows é
possível gerar um arquivo .apk com o seguinte comando:

```bash
flutter build apk --release
```

## Apoio
Link para instalação do Flutter SDK:

[Flutter SDK](https://flutter.dev/docs/get-started/install)


Link para a API no github:

[API no github](https://github.com/Ysr7/Images.api)

## Instalação dos plugins Dart e Flutter

No Visual Studio Code (VS Code):

Ao abrir o Visual Studio Code, clica no ícone de extensões e procure por
Dart e clique em Install em seguida, faça o mesmo com o Flutter.

No Android Studio

Na tela inicial do Android Studio clique em File > Plugins e procure por
Dart e clique em Install em seguida, faça o mesmo com o Flutter.
