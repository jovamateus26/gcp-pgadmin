# Estágio de build para instalar o gcsfuse
FROM debian:buster as gcsfuse-builder

RUN apt-get update && apt-get install -y apt-transport-https gnupg
RUN echo "deb https://packages.cloud.google.com/apt gcsfuse-buster main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get install -y gcsfuse

# Estágio final
FROM dpage/pgadmin4:latest

# Copia o binário gcsfuse do estágio de build
COPY --from=gcsfuse-builder /usr/bin/gcsfuse /usr/bin/gcsfuse

# Exponha a porta correta para o Cloud Run
EXPOSE 8080

# Comando de inicialização
CMD ["sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh"]
