#!/bin/bash

# Caminho para o arquivo .htpasswd
HTPASSWD_FILE="/etc/apache2/.htpasswd"

# Nome de usuário e senha desejados a partir das variáveis de ambiente
USERNAME=${HTPASSWD_USERNAME:-"default_user"}
PASSWORD=${HTPASSWD_PASSWORD:-"default_pass"}

# Cria ou atualiza o arquivo .htpasswd com o usuário e senha
htpasswd -cb $HTPASSWD_FILE $USERNAME $PASSWORD

# Inicia o Apache em primeiro plano
apachectl -D FOREGROUND
