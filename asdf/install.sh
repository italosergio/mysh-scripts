#!/bin/bash

set -e  # Para encerrar o script em caso de erro

# Atualiza pacotes e instala dependências
echo -e "\e[34mAtualizando pacotes e instalando dependências...\e[0m"
sudo apt update && sudo apt install -y \
    git curl wget \
    build-essential \
    libssl-dev zlib1g-dev \
    libreadline-dev libbz2-dev \
    libsqlite3-dev

# Remove cmdtest caso esteja instalado
if dpkg -l | grep -q cmdtest; then
    echo -e "\e[34mRemovendo cmdtest...\e[0m"
    sudo apt remove -y cmdtest
fi

# Adiciona o repositório oficial do Yarn
echo -e "\e[34mAdicionando repositório do Yarn...\e[0m"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo tee /etc/apt/trusted.gpg.d/yarn.gpg > /dev/null
echo "deb https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Atualiza pacotes e instala o Yarn corretamente
sudo apt update && sudo apt install -y yarn

# Define a versão do asdf a ser instalada
ASDF_VERSION="v0.14.0"

# Clona o repositório do asdf
echo -e "\e[34mVerificando instalação do asdf...\e[0m"
if [ ! -d "$HOME/.asdf" ]; then
    echo -e "\e[34mClonando o repositório do asdf...\e[0m"
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch $ASDF_VERSION
else
    echo -e "\e[34masdf já está instalado. Pulando clonagem.\e[0m"
fi

# Adiciona asdf ao shell
SHELL_CONFIG="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo -e "\e[34mConfigurando o asdf no shell...\e[0m"
if ! grep -q 'asdf.sh' "$SHELL_CONFIG"; then
    echo '. "$HOME/.asdf/asdf.sh"' >> "$SHELL_CONFIG"
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> "$SHELL_CONFIG"
    echo -e "\e[34mConfiguração adicionada ao $SHELL_CONFIG\e[0m"
else
    echo -e "\e[34masdf já está configurado no $SHELL_CONFIG\e[0m"
fi

# Recarrega o shell
echo -e "\e[34mRecarregando shell...\e[0m"
source "$SHELL_CONFIG"

# Instala plugins do asdf, caso não estejam instalados
echo -e "\e[34mVerificando e instalando plugins...\e[0m"

# Exemplo de plugin: Node.js
if ! asdf plugin-list | grep -q 'nodejs'; then
    echo -e "\e[34mInstalando plugin Node.js...\e[0m"
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    echo -e "\e[34mPlugin Node.js instalado com sucesso!\e[0m"
fi

# Instala versão do Node.js (exemplo com a versão 16.0.0)
echo -e "\e[34mInstalando a versão do Node.js...\e[0m"
asdf install nodejs 16.0.0

# Instala o Yarn com o asdf
if ! asdf plugin-list | grep -q 'yarn'; then
    echo -e "\e[34mInstalando plugin Yarn...\e[0m"
    asdf plugin-add yarn https://github.com/asdf-community/asdf-yarn.git
    echo -e "\e[34mPlugin Yarn instalado com sucesso!\e[0m"
fi

# Instala a versão do Yarn
echo -e "\e[34mInstalando a versão do Yarn...\e[0m"
asdf install yarn latest

# Define as versões globais
echo -e "\e[34mDefinindo versões globais...\e[0m"
asdf global nodejs 16.0.0
asdf global yarn latest

# Testa a instalação
echo -e "\e[34mVersão do asdf instalada:\e[0m"
asdf --version
echo -e "\e[34mVersão do Node.js instalada:\e[0m"
node --version
echo -e "\e[34mVersão do Yarn instalada:\e[0m"
yarn --version

