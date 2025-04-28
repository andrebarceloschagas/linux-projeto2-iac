#!/bin/bash

echo "Atualizando o sistema..."
apt-get update -y
apt-get upgrade -y

echo "Instalando o Apache2..."
apt-get install apache2 -y

echo "Instalando o unzip..."
apt-get install unzip -y

echo "Baixando o arquivo do site..."
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

echo "Descompactando o arquivo..."
unzip main.zip
cd linux-site-dio-main

echo "Copiando os arquivos para o diretório do Apache..."
cp -R * /var/www/html/
