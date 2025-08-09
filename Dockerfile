FROM dpage/pgadmin4:latest

# Instala o utilitário GCS FUSE
USER root
# Instala curl e gnupg usando apk
RUN apk add --no-cache curl gnupg
RUN mkdir -p /etc/apk/keyrings
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apk/keyrings/gcsfuse.gpg
RUN echo "deb [signed-by=/etc/apk/keyrings/gcsfuse.gpg] https://packages.cloud.google.com/apt gcsfuse-alpine main" | tee /etc/apk/sources.list.d/gcsfuse.list
RUN apk add --no-cache gcsfuse
USER pgadmin

# Exponha a porta correta para o Cloud Run
EXPOSE 8080

# Comando de inicialização
CMD [ "sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh" ]
