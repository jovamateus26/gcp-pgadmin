FROM dpage/pgadmin4:latest

# Instala o utilitário GCS FUSE
# Primeiro, cria o diretório sources.list.d para evitar o erro.
RUN sudo mkdir -p /etc/apt/sources.list.d/
RUN echo "deb https://packages.cloud.google.com/apt gcsfuse-buster main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN sudo apt-get update && sudo apt-get install gcsfuse -y

# Exponha a porta correta para o Cloud Run
EXPOSE 8080

# Comando de inicialização
CMD [ "sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh" ]
