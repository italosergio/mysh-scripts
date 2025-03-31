#!/bin/bash

set -e  # Para encerrar o script em caso de erro

# Remove o diretório do asdf
echo -e "\e[34mRemovendo o asdf...\e[0m"
if [ -d "$HOME/.asdf" ]; then
    rm -rf "$HOME/.asdf"
    echo -e "\e[34mDiretório do asdf removido.\e[0m"
else
    echo -e "\e[34mo asdf não está instalado. Pulando remoção.\e[0m"
fi

# Remove configurações do shell
SHELL_CONFIG="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo -e "\e[34mRemovendo configurações do asdf no shell...\e[0m"
if grep -q 'asdf.sh' "$SHELL_CONFIG"; then
    sed -i '/asdf.sh/d' "$SHELL_CONFIG"
    sed -i '/asdf.bash/d' "$SHELL_CONFIG"
    echo -e "\e[34mConfigurações do asdf removidas do $SHELL_CONFIG\e[0m"
else
    echo -e "\e[34masdf não está configurado no $SHELL_CONFIG. Pulando remoção.\e[0m"
fi

# Recarrega o shell
echo -e "\e[34mRecarregando shell...\e[0m"
source "$SHELL_CONFIG"

echo -e "\e[34mRemoção do asdf concluída.\e[0m"

