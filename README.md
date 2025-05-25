# Projeto: Script de Provisionamento de Servidor Web Apache com Site Simples (IaC)

Este projeto contém um script Bash (`script2-iac.sh`) para automatizar a configuração de um servidor web Apache básico e o deploy de um site estático em um ambiente Linux baseado em Debian/Ubuntu.

## Funcionalidades

O script realiza as seguintes operações automaticamente:

1.  **Verificação de Root**: Garante que o script seja executado com privilégios de superusuário.
2.  **Tratamento de Erros**: Utiliza `set -e` para que o script saia imediatamente se qualquer comando falhar.
3.  **Atualização do Sistema**: Atualiza a lista de pacotes e os pacotes instalados (`apt-get update -y`, `apt-get upgrade -y`).
4.  **Instalação de Pacotes Essenciais**: Instala o servidor web Apache (`apache2`), a ferramenta de descompactação (`unzip`) e a ferramenta de sincronização de arquivos (`rsync`) com `apt-get install apache2 unzip rsync -y`.
5.  **Criação de Diretório Temporário**: Cria um diretório temporário único (ex: `/tmp/web_deploy_$$`) para isolar os arquivos de download e descompactação.
6.  **Download do Site**: Baixa um arquivo `.zip` (de forma silenciosa com `wget -q`) contendo os arquivos de um site a partir de um repositório GitHub.
7.  **Descompactação**: Extrai o conteúdo do arquivo `.zip` baixado (de forma silenciosa com `unzip -q`) no diretório temporário.
8.  **Verificação do Conteúdo**: Confirma se o diretório esperado do site foi criado após a descompactação.
9.  **Deploy do Site**: Copia os arquivos extraídos do site para o diretório raiz padrão do Apache (`/var/www/html/`) usando `rsync -avh --delete`. A opção `--delete` remove arquivos do destino que não existem na origem, garantindo uma sincronização limpa.
10. **Limpeza Segura**: Remove o diretório temporário e seu conteúdo após a conclusão do deploy.
11. **Logs Detalhados**: Fornece mensagens de log informativas sobre o progresso de cada etapa.

## Pré-requisitos

* Sistema operacional Linux baseado em Debian/Ubuntu (ex: Ubuntu, Debian, Linux Mint, Kali Linux).
* Permissões de administrador (root) para executar o script (uso do `sudo`).
* Conexão com a internet (para atualizar o sistema e baixar o Apache, unzip e o arquivo do site).
* O utilitário `wget` (geralmente pré-instalado, mas necessário para o download).

## Como Executar

1.  Copie o script `script2-iac.sh` para o seu ambiente local.
2.  Dê permissão de execução ao script:
    ```bash
    chmod +x script2-iac.sh
    ```
3.  Execute o script como administrador:
    ```bash
    sudo ./script2-iac.sh
    ```
4.  O script executará todas as etapas de forma não interativa devido ao uso da flag `-y` nos comandos `apt-get`.

## Estrutura do Script

O script segue uma ordem lógica e organizada em seções:

*   Verificação de privilégios de root.
*   Definição de `set -e` para sair em caso de erro.
*   Atualização inicial do sistema.
*   Instalação das dependências (Apache2, unzip, rsync).
*   Criação e navegação para um diretório temporário seguro.
*   Download (silencioso) dos arquivos do site.
*   Descompactação (silenciosa) dos arquivos do site.
*   Verificação da existência do diretório do site descompactado.
*   Cópia (deploy) dos arquivos do site para o diretório web usando `rsync` (com deleção de arquivos não existentes na origem).
*   Limpeza segura do diretório temporário.
*   Mensagem de finalização.

## Exemplo de Saída

Ao executar o script, você verá mensagens indicando o progresso das operações, como:

```
Iniciando o provisionamento do servidor web Apache e deploy do site...
Atualizando o sistema...
Sistema atualizado.
Instalando pacotes: Apache2, Unzip, Rsync...
Pacotes essenciais instalados.
Criando diretório temporário: /tmp/web_deploy_...
Diretório temporário alterado para: /tmp/web_deploy_...
Baixando o arquivo do site...
Arquivo do site baixado em /tmp/web_deploy_.../main.zip.
Descompactando o arquivo do site...
Arquivo descompactado em /tmp/web_deploy_....
Verificando a existência do diretório do site: linux-site-dio-main...
Diretório linux-site-dio-main encontrado. Copiando os arquivos do site para o diretório do Apache...
Site copiado para /var/www/html/.
Limpando arquivos temporários de /tmp/web_deploy_......
Limpeza concluída.
Provisionamento do servidor web e deploy do site concluídos com sucesso!
```
*(Nota: A saída real incluirá também as mensagens dos comandos `apt-get` se não forem totalmente suprimidas, e `rsync` detalhando os arquivos transferidos.)*

## Observações

* **Site Específico**: O script está configurado para baixar e implantar o site do repositório `https://github.com/denilsonbonatti/linux-site-dio`.
* **Sobrescrita**: O script **sobrescreverá** qualquer conteúdo existente no diretório `/var/www/html/`. Tenha cuidado ao executar em um servidor que já hospeda outros sites nesse local.
* **Não Interativo**: O uso da flag `-y` nos comandos `apt-get` assume "sim" para todas as perguntas, tornando a execução automática.

## Autor

Este projeto foi desenvolvido por [@andrebarceloschagas](github.com/andrebarceloschagas). Sinta-se à vontade para contribuir ou sugerir melhorias.

## Licença

Este projeto está licenciado sob a MIT License (ou ajuste conforme sua preferência).
