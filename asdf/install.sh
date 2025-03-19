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

# Testa a instalação
echo -e "\e[34mVersão do asdf instalada:\e[0m"
asdf --version
