#!/bin/bash

echo "🔐 Instalação da Chave Privada SSH"

# 📌 Perguntar caminho da chave privada ou colar diretamente
echo "Código para gerar chaves (ssh-keygen -t rsa -b 4096 -C "seu_email@example.com")"
read -p "Digite o caminho da chave privada (ou pressione Enter para colar a chave): " KEY_PATH

if [ -z "$KEY_PATH" ]; then
    echo "📋 Cole sua chave privada abaixo e pressione Ctrl+D quando terminar:"
    KEY_PATH=~/.ssh/id_rsa
    mkdir -p ~/.ssh
    cat > "$KEY_PATH"
else
    cp "$KEY_PATH" ~/.ssh/
    KEY_PATH=~/.ssh/$(basename "$KEY_PATH")
fi

# 🔒 Definir permissões corretas
chmod 600 "$KEY_PATH"
echo "✅ Permissões da chave privada ajustadas para 600."

# 🚀 Perguntar se deseja adicionar ao SSH Agent
read -p "Deseja adicionar essa chave ao SSH Agent? (s/n): " ADD_AGENT
if [[ "$ADD_AGENT" =~ ^[Ss]$ ]]; then
    eval "$(ssh-agent -s)"
    ssh-add "$KEY_PATH"
    echo "🔑 Chave adicionada ao SSH Agent!"
fi

# 🛠️ Perguntar se deseja testar a conexão SSH
read -p "Deseja testar a conexão SSH com um servidor? (s/n): " TEST_SSH
if [[ "$TEST_SSH" =~ ^[Ss]$ ]]; then
    read -p "Digite o endereço do servidor (exemplo: user@servidor.com): " SSH_SERVER
    ssh -i "$KEY_PATH" "$SSH_SERVER"
fi

echo "🚀 Processo concluído!"
