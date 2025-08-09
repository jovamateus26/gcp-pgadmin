FROM dpage/pgadmin4:latest

# Instala o utilitário GCS FUSE
USER root
# Instala curl e gnupg para que os comandos seguintes funcionem
RUN apt-get update && apt-get install -y curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/gcsfuse.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/gcsfuse.gpg] https://packages.cloud.google.com/apt gcsfuse-buster main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN apt-get update && apt-get install -y gcsfuse
USER pgadmin

# Exponha a porta correta para o Cloud Run
EXPOSE 8080

# Comando de inicialização
CMD [ "sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh" ]
