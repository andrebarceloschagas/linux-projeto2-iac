# Projeto: Script de Provisionamento de Servidor Web Apache com Site Simples (IaC)

Este projeto contém um script Bash (`script2-iac.sh`) para automatizar a configuração de um servidor web Apache básico e o deploy de um site estático em um ambiente Linux baseado em Debian/Ubuntu.

## Funcionalidades

O script realiza as seguintes operações automaticamente:

1.  **Atualização do Sistema**: Atualiza a lista de pacotes e os pacotes instalados (`apt-get update -y`, `apt-get upgrade -y`).
2.  **Instalação do Apache2**: Instala o servidor web Apache (`apt-get install apache2 -y`).
3.  **Instalação do Unzip**: Instala a ferramenta `unzip` necessária para descompactar arquivos (`apt-get install unzip -y`).
4.  **Download do Site**: Baixa um arquivo `.zip` contendo os arquivos de um site a partir de um repositório GitHub (`wget ...`).
5.  **Descompactação**: Extrai o conteúdo do arquivo `.zip` baixado (`unzip main.zip`).
6.  **Deploy do Site**: Copia os arquivos extraídos do site para o diretório raiz padrão do Apache (`/var/www/html/`), substituindo qualquer conteúdo existente.

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

O script segue uma ordem lógica:
* Atualização inicial do sistema.
* Instalação das dependências (Apache2, unzip).
* Download e descompactação dos arquivos do site.
* Cópia (deploy) dos arquivos do site para o diretório web.

## Exemplo de Saída

Ao executar o script, você verá mensagens indicando o progresso das operações, como:

```
Atualizando o sistema...
Instalando o Apache2...
Instalando o unzip...
Baixando o arquivo do site...
Descompactando o arquivo...
Copiando os arquivos para o diretório do Apache...
```
*(Nota: A saída real incluirá também as mensagens dos comandos `apt-get`, `wget`, `unzip`, `cp`)*

## Observações

* **Site Específico**: O script está configurado para baixar e implantar o site do repositório `https://github.com/denilsonbonatti/linux-site-dio`.
* **Sobrescrita**: O script **sobrescreverá** qualquer conteúdo existente no diretório `/var/www/html/`. Tenha cuidado ao executar em um servidor que já hospeda outros sites nesse local.
* **Não Interativo**: O uso da flag `-y` nos comandos `apt-get` assume "sim" para todas as perguntas, tornando a execução automática.

## Autor

Este projeto foi desenvolvido por [@andrebarceloschagas](github.com/andrebarceloschagas). Sinta-se à vontade para contribuir ou sugerir melhorias.

## Licença

Este projeto está licenciado sob a MIT License (ou ajuste conforme sua preferência).
```
