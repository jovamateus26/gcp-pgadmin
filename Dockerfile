# Estágio de build para instalar o gcsfuse
FROM debian:buster as gcsfuse-builder

# Substitui os URLs de repositório para apontar para o arquivo
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/archive.debian.org\/debian-security/g' /etc/apt/sources.list

# Adiciona o repositório do GCSFuse e instala os pacotes
RUN apt-get update && apt-get install -y apt-transport-https gnupg curl
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb http://packages.cloud.google.com/apt gcsfuse-buster main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN apt-get update && apt-get install -y gcsfuse

# Estágio final
FROM dpage/pgadmin4:latest

# Copia o binário gcsfuse do estágio de build
COPY --from=gcsfuse-builder /usr/bin/gcsfuse /usr/bin/gcsfuse

# Exponha a porta correta para o Cloud Run
EXPOSE 80

# Comando de inicialização
CMD ["sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh"]
