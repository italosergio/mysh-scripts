#!/bin/bash

# Diretório do repositório
REPO_DIR="$HOME/github@italosergio/zsh_history"

# Arquivo de histórico do Zsh
HIST_FILE="$HOME/.zsh_history"
BACKUP_FILE="$REPO_DIR/.zsh_history"

# Verifica se o diretório do repositório existe
if [ ! -d "$REPO_DIR" ]; then
    echo "Erro: Diretório $REPO_DIR não encontrado!"
    exit 1
fi

# Copia o histórico para o repositório
cp "$HIST_FILE" "$BACKUP_FILE"

# Navega até o repositório
cd "$REPO_DIR" || exit 1

# Adiciona ao Git
git add .zsh_history

# Gera timestamp para o commit
TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
git commit -m "update $TIMESTAMP"

# Faz o push
git push

echo "✅ Histórico atualizado e enviado para o repositório!"
