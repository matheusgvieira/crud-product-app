# Aplicativo de Catálogo de Produtos

Bem-vindo ao Aplicativo de Catálogo de Produtos! Este aplicativo permite navegar e gerenciar uma lista de produtos.

## Pré-requisitos

Antes de executar o aplicativo, certifique-se de ter o seguinte instalado em seu sistema:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

## Começando

Siga estas etapas para executar o aplicativo em seu dispositivo iOS usando o terminal ou o Android Studio:

```sh
# Clone o repositório para sua máquina local
git clone https://github.com/seunome/aplicativo-catalogo-produtos.git

# Navegue até o diretório do aplicativo
cd aplicativo-catalogo-produtos

# Instale as dependências necessárias
flutter pub get

# Configure a Variável de Ambiente:
# Crie um arquivo .env no diretório raiz do aplicativo e defina a variável de ambiente API_URL
echo "API_URL=https://api.exemplo.com" > .env

# Execute o aplicativo no iOS:
# Abra um terminal e navegue até o diretório do aplicativo
# Execute o seguinte comando para iniciar o aplicativo em seu dispositivo iOS ou simulador
flutter run

# Ou, para especificar a URL da API como um argumento de linha de comando:
flutter run --dart-define=API_URL=https://api.exemplo.com
