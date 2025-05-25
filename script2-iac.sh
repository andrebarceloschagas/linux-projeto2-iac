#!/bin/bash

# Faz o script sair imediatamente se um comando falhar
set -e

# Verifica se o script está sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
  echo "Este script precisa ser executado como root." >&2
  exit 1
fi

echo "Iniciando o provisionamento do servidor web Apache e deploy do site..."

# --- Atualização do Sistema ---
echo "Atualizando o sistema..."
apt-get update -y
apt-get upgrade -y
echo "Sistema atualizado."

# --- Instalação de Pacotes Essenciais ---
echo "Instalando pacotes: Apache2, Unzip, Rsync..."
apt-get install apache2 unzip rsync -y
echo "Pacotes essenciais instalados."

# --- Download e Preparação do Site ---
TEMP_DIR="/tmp/web_deploy_$$" # Cria um nome de diretório temporário único
echo "Criando diretório temporário: $TEMP_DIR..."
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"
echo "Diretório temporário alterado para: $(pwd)"

echo "Baixando o arquivo do site..."
wget -q https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -O main.zip
echo "Arquivo do site baixado em $(pwd)/main.zip."

echo "Descompactando o arquivo do site..."
unzip -q main.zip
echo "Arquivo descompactado em $(pwd)."

# --- Deploy do Site ---
SITE_DIR_NAME="linux-site-dio-main" # Nome esperado do diretório após descompactar
echo "Verificando a existência do diretório do site: $SITE_DIR_NAME..."
if [ -d "$SITE_DIR_NAME" ]; then
  echo "Diretório $SITE_DIR_NAME encontrado. Copiando os arquivos do site para o diretório do Apache..."
  cd "$SITE_DIR_NAME"
  rsync -avh --delete . /var/www/html/
  echo "Site copiado para /var/www/html/."
  cd .. # Volta para TEMP_DIR para limpeza
else
  echo "Erro: Diretório '$SITE_DIR_NAME' não encontrado em $(pwd) após descompactar." >&2
  echo "Limpando arquivos temporários antes de sair..."
  rm -rf "$TEMP_DIR"
  echo "Limpeza concluída."
  exit 1
fi

# --- Limpeza ---
echo "Limpando arquivos temporários de $TEMP_DIR..."
cd / # Mudar para um diretório seguro antes de remover TEMP_DIR
rm -rf "$TEMP_DIR"
echo "Limpeza concluída."

echo "Provisionamento do servidor web e deploy do site concluídos com sucesso!"
