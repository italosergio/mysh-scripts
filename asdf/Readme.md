Claro, aqui está o README atualizado conforme solicitado:

---

# install_uninstall_asdf.sh - Guia de Uso

### Sobre o Script

Este script automatiza a instalação e remoção do gerenciador de versões asdf. Ele suporta múltiplos idiomas e garante que as dependências necessárias sejam instaladas corretamente.

### Como Executar

1. Baixe o script ou clone o repositório:

   ```bash
   git clone https://github.com/italosergio/mysh-scripts.git
   cd mysh-scripts/asdf
   ```

2. Dê permissão para executar os arquivos:

   ```bash
   chmod +x install.sh
   ```
   ```bash
   chmod +x uninstall.sh
   ```

3. Execute o script no Bash:

   ```bash
   ./install.sh
   ```

   ```bash
   ./uninstall.sh
   ```

### Opções do Script

Durante a execução, o script solicitará:

- Opção de instalação ou remoção do asdf

Se escolher **instalar**, ele:

- Atualiza os pacotes e instala as dependências necessárias
- Faz o download e configuração do asdf
- Adiciona o asdf ao shell Bash
- Recarrega as configurações do shell

Se escolher **remover**, ele:

- Apaga a pasta de instalação do asdf
- Remove as referências ao asdf do `.bashrc` e `.zshrc`

### Licença e Uso

Este código é open source e pode ser utilizado para fins comerciais ou não, desde que haja a devida creditação ao repositório do script: [https://github.com/italosergio/mysh-scripts](https://github.com/italosergio/mysh-scripts).

---
