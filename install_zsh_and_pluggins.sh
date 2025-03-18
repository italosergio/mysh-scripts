#!/bin/bash

# Instalação do Oh My Zsh se não estiver instalado
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
  echo "Oh My Zsh já está instalado."
fi

# Diretório de plugins personalizados
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Função para clonar plugins
install_plugin() {
  local repo=$1
  local dir=$2
  if [ ! -d "$dir" ]; then
    echo "Instalando $repo..."
    git clone --depth=1 "$repo" "$dir"
  else
    echo "$repo já está instalado."
  fi
}

# Instalação dos plugins
install_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
install_plugin https://github.com/junegunn/fzf.git "$HOME/.fzf"
install_plugin https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
install_plugin https://github.com/supercrabtree/k "$ZSH_CUSTOM/plugins/k"
install_plugin https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Instalação do FZF
if [ ! -f "$HOME/.fzf/bin/fzf" ]; then
  echo "Instalando FZF..."
  $HOME/.fzf/install --all
else
  echo "FZF já está instalado."
fi

# Configuração do .zshrc
ZSHRC="$HOME/.zshrc"

echo "Atualizando .zshrc..."
sed -i '/^plugins=/c\plugins=(git zsh-syntax-highlighting fzf zsh-autosuggestions k)' "$ZSHRC"
sed -i '/^ZSH_THEME=/c\ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"

# Aplicar mudanças
source "$ZSHRC"

echo "Instalação concluída! Reinicie o terminal para aplicar as configurações."
