# :ballot_box_with_check: F-Tasks Frontend

## Descrição
Este projeto contém o código do Frontend da aplicação "F-Tasks". O foco deste projeto é muito voltado para a parte de autenticação e autorização.

Resumidamente, para usar a ferramenta, o usuário precisa criar um login fornecendo dados como nome, email e senha, e ao entrar com suas credenciais, a aplicação retorna seu nome e um token de acesso. Para acessar recursos protegidos, como a lista de suas tarefas, criação de novas tarefas e atualização do status das mesmas, o usuário precisa fornecer seu token junto à requisição.

Além disso, é preciso cuidar da data de expiração do token. Caso esteja expirado, é necessário fazer o processo de refresh do token, onde o backend fornece um novo token válido e o usuário pode utilizá-lo para fazer novamente suas requisições.

## Tecnologias utilizadas na aplicação

- [Flutter](https://flutter.dev/) - Framework para o desenvolvimento do Frontend da aplicação.
- [flutter_modular](https://pub.dev/packages/flutter_modular) - Ferramenta capaz de atuar como _service locator_ e capaz de fazer navegação entre telas na aplicação.
- [dio](https://pub.dev/packages/dio) - Ferramenta altamente customizável para requisições HTTP, com suporte a interceptadores, formulários, downloads, etc.
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Ferramenta de armazenamento local de dados.
- [rx_notifier](https://pub.dev/packages/rx_notifier) - Ferramenta de reatividade transparente.
- [google_fonts](https://pub.dev/packages/google_fonts) - Ferramenta para obtenção das fontes do Google Fonts.

## Instalação

```bash
$ flutter pub get
```

## Executando a aplicação

```bash
$ flutter run
```
