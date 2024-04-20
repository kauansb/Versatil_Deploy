FROM ubuntu:latest

RUN apt-get update && apt-get install -y apache2 apache2-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# arquivo de configuração do Apache com autenticação
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# script de inicialização para o container
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

COPY ./shared /var/www/html

# permissões apropriadas
RUN chown -R www-data:www-data /var/www/html

# diretiva ServerName para eliminar a advertência
RUN echo "ServerName Cursos" >> /etc/apache2/apache2.conf

EXPOSE 80

# Habilitar mod_auth_basic
RUN a2enmod auth_basic

# script de inicialização quando o container iniciar
CMD ["/usr/local/bin/init.sh"]